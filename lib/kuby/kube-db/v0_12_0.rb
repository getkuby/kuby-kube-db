module Kuby
  module KubeDB
    class V0_12_0
      KUBEDB_VERSION = '0.12.0'.freeze
      REPO_NAME = 'appscode'.freeze
      REPO_URL = 'https://charts.appscode.com/stable/'.freeze
      OPERATOR_DEPLOYMENT_NAME = 'kubedb-operator'.freeze
      CATALOG_RELEASE_NAME = 'kubedb-catalog'.freeze
      OPERATOR_CHART_NAME = 'appscode/kubedb'.freeze
      CATALOG_CHART_NAME = 'appscode/kubedb-catalog'.freeze
      WAIT_INTERVAL = 5  # seconds
      WAIT_MAX = 120     # seconds

      OPERATOR_PARAMS = {
        'apiserver.enableValidatingWebhook' => 'true',
        'apiserver.enableMutatingWebhook'   => 'true'
      }

      OPERATOR_PARAMS.freeze

      attr_reader :environment

      def initialize(environment)
        @environment = environment
      end

      def install
        Kuby.logger.info("Setting up KubeDB v#{KUBEDB_VERSION}")

        Kuby.logger.info('Fetching Helm chart')
        helm_cli.add_repo(REPO_NAME, REPO_URL)
        helm_cli.update_repos

        Kuby.logger.info('Deploying KubeDB operator')
        operator_deployed? ? upgrade_operator : install_operator

        kubernetes_cli.wait_for_deployment(KubeDB::NAMESPACE, OPERATOR_DEPLOYMENT_NAME) do
          Kuby.logger.info('Waiting for KubeDB operator deployment')
        end

        kubernetes_cli.wait_for_api_resources do
          Kuby.logger.info('Waiting for API resources to become available')
        end

        Kuby.logger.info('Deploying KubeDB catalog')
        catalog_deployed? ? upgrade_catalog : install_catalog

        Kuby.logger.info("KubeDB v#{KUBEDB_VERSION} setup finished")
      end

      def uninstall
        Kuby.logger.info("Uninstalling KubeDB v#{KUBEDB_VERSION}")

        if helm_cli.release_exists?(CATALOG_RELEASE_NAME, namespace: KubeDB::NAMESPACE)
          helm_cli.uninstall_release(CATALOG_RELEASE_NAME, namespace: KubeDB::NAMESPACE)
        end

        if helm_cli.release_exists?(KubeDB::RELEASE_NAME, namespace: KubeDB::NAMESPACE)
          helm_cli.uninstall_release(KubeDB::RELEASE_NAME, namespace: KubeDB::NAMESPACE)
        end

        kubernetes_cli.delete_objects('validatingwebhookconfiguration', nil, { 'app' => 'kubedb' })
        kubernetes_cli.delete_objects('mutatingwebhookconfiguration', nil, { 'app' => 'kubedb' })
        kubernetes_cli.delete_objects('psp', nil, { 'app' => 'kubedb-catalog' })
        kubernetes_cli.delete_objects('apiservice', nil, { 'app' => 'kubedb' })

        loop do
          Kuby.logger.info('Waiting for kubedb operator pod to stop running')
          objects = kubernetes_cli.get_objects('pods', KubeDB::NAMESPACE, { 'app' => 'kubedb' })
          break if objects.empty?
          sleep 5
        end

        # TODO: also do this for mysqls (maybe other types too?)
        postgreses = kubernetes_cli.get_objects('postgres', '*')
        postgreses.each do |postgres|
          name = postgres.dig('metadata', 'name')
          namespace = postgres.dig('metadata', 'namespace')
          kubernetes_cli.patch_object('postgres', name, '\'{"metadata":{"finalizers":[]}}\'', 'merge', namespace)
          kubernetes_cli.delete_object('postgres', name, namespace, true, cascade: false)
        end

        crds = kubernetes_cli.get_objects('crds', KubeDB::NAMESPACE, { 'app' => 'kubedb' })
        thread = Thread.new { kubernetes_cli.delete_objects('crds', nil, { 'app' => 'kubedb' }) }

        crds.each do |crd|
          begin
            kubernetes_cli.patch_object(
              'crd', crd.dig('metadata', 'name'), '\'{"metadata":{"finalizers":[]}}\''
            )
          rescue KubernetesCLI::PatchResourceError
            Kuby.logger.error("Unable to patch CRD #{crd.dig('metadata', 'name')}")
          end
        end

        thread.join

        remaining_objects = {
          'apiservice' => %w(v1alpha1.appcatalog.appscode.com),
          'crd' => %w(appbindings.appcatalog.appscode.com),
          'clusterrole' => %w(
            appscode:appcatalog:admin
            appscode:appcatalog:view
            kubedb:core:admin
            kubedb:core:edit
            kubedb:core:view
          )
        }

        remaining_objects.each do |kind, names|
          names.each do |name|
            begin
              kubernetes_cli.delete_object(kind, name)
            rescue KubernetesCLI::DeleteResourceError
              Kuby.logger.error("Unable to delete #{kind} #{name}")
            end
          end
        end

        Kuby.logger.info("KubeDB v#{KUBEDB_VERSION} uninstalled")
      end

      def before_deploy(_manifest)
        # no-op
      end

      private

      def install_operator
        helm_cli.install_chart(OPERATOR_CHART_NAME,
          release: KubeDB::RELEASE_NAME,
          version: KUBEDB_VERSION,
          namespace: NAMESPACE,
          params: OPERATOR_PARAMS
        )
      end

      def upgrade_operator
        helm_cli.upgrade_chart(OPERATOR_CHART_NAME,
          release: KubeDB::RELEASE_NAME,
          version: KUBEDB_VERSION,
          namespace: KubeDB::NAMESPACE,
          params: OPERATOR_PARAMS
        )
      end

      def install_catalog
        helm_cli.install_chart(CATALOG_CHART_NAME,
          release: CATALOG_RELEASE_NAME,
          version: KUBEDB_VERSION,
          namespace: KubeDB::NAMESPACE
        )
      end

      def upgrade_catalog
        helm_cli.upgrade_chart(CATALOG_CHART_NAME,
          release: CATALOG_RELEASE_NAME,
          version: KUBEDB_VERSION,
          namespace: KubeDB::NAMESPACE
        )
      end

      def operator_deployed?
        helm_cli.release_exists?(KubeDB::RELEASE_NAME, namespace: KubeDB::NAMESPACE)
      end

      def catalog_deployed?
        helm_cli.release_exists?(CATALOG_RELEASE_NAME, namespace: KubeDB::NAMESPACE)
      end

      def helm_cli
        provider.helm_cli
      end

      def kubernetes_cli
        provider.kubernetes_cli
      end

      def provider
        environment.kubernetes.provider
      end
    end
  end
end
