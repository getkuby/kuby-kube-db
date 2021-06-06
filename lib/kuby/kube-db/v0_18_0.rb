require 'helm-cli'
require 'kuby'
require 'kuby/kube-db/version'
require 'readline'
require 'openssl'
require 'base64'
require 'kube-dsl'

module Kuby
  module KubeDB
    class V0_18_0
      class LicenseServerAuth
        attr_reader :name, :email_address, :token

        def initialize(name, email_address, token)
          @name = name
          @email_address = email_address
          @token = token
        end
      end

      class License
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def cert
          @cert ||= OpenSSL::X509::Certificate.new(data)
        end

        def expired?
          Time.now.utc > cert.not_after
        end
      end

      KUBEDB_VERSION = '0.18.0'.freeze
      NAMESPACE = 'kube-system'.freeze
      REPO_NAME = 'appscode'.freeze
      REPO_URL = 'https://charts.appscode.com/stable/'.freeze
      OPERATOR_DEPLOYMENT_NAME = "#{KubeDB::RELEASE_NAME}-kubedb-community".freeze
      OPERATOR_CHART_NAME = 'appscode/kubedb'.freeze
      LICENSE_SECRET = "#{KubeDB::RELEASE_NAME}-kubedb-community-license".freeze
      LICENSE_SERVER_TOKEN_SECRET_NAME = 'kuby-kubedb-license-server-token'.freeze
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

        Kuby.logger.info('Fetching KubeDB Helm chart')
        helm_cli.add_repo(REPO_NAME, REPO_URL)
        helm_cli.update_repos

        Kuby.logger.info('Determining KubeDB license status')
        license = renew_license_if_necessary(get_current_license)

        Kuby.logger.info('Deploying KubeDB operator')
        operator_deployed? ? upgrade_operator(license) : install_operator(license)

        wait_for_install

        Kuby.logger.info("KubeDB v#{KUBEDB_VERSION} setup finished")
      end

      def uninstall
        Kuby.logger.info("Uninstalling KubeDB v#{KUBEDB_VERSION}")
        helm_cli.uninstall_release(KubeDB::RELEASE_NAME, namespace: KubeDB::NAMESPACE)
        Kuby.logger.info("KubeDB v#{KUBEDB_VERSION} uninstalled")
      end

      def before_deploy
        Kuby.logger.info('Determining KubeDB license status')
        license = get_current_license

        if !license || license.expired?
          license = renew_license_if_necessary(license)

          helm_cli.upgrade_chart(OPERATOR_CHART_NAME,
            release: KubeDB::RELEASE_NAME,
            version: Kuby::KubeDB::KUBEDB_VERSION,
            namespace: KubeDB::NAMESPACE,
            reuse_values: true,
            params: { 'global.license' => license.data }
          )

          wait_for_install

          Kuby.logger.info('KubeDB license renewed successfully')
        else
          Kuby.logger.info('Valid existing KubeDB license found')
        end
      end

      private

      def install_operator(license)
        helm_cli.install_chart(OPERATOR_CHART_NAME,
          release: KubeDB::RELEASE_NAME,
          version: Kuby::KubeDB::KUBEDB_VERSION,
          namespace: KubeDB::NAMESPACE,
          params: OPERATOR_PARAMS.merge('global.license' => license.data)
        )
      end

      def upgrade_operator(license)
        helm_cli.upgrade_chart(OPERATOR_CHART_NAME,
          release: KubeDB::RELEASE_NAME,
          version: Kuby::KubeDB::KUBEDB_VERSION,
          namespace: KubeDB::NAMESPACE,
          params: OPERATOR_PARAMS.merge('global.license' => license.data)
        )
      end

      def wait_for_install
        kubernetes_cli.wait_for_deployment(KubeDB::NAMESPACE, OPERATOR_DEPLOYMENT_NAME) do
          Kuby.logger.info('Waiting for KubeDB operator deployment')
        end

        kubernetes_cli.wait_for_api_resources do
          Kuby.logger.info('Waiting for API resources to become available')
        end
      end

      def operator_deployed?
        helm_cli.release_exists?(KubeDB::RELEASE_NAME, namespace: KubeDB::NAMESPACE)
      end

      def get_current_license
        license_secret = kubernetes_cli.get_object('Secret', KubeDB::NAMESPACE, LICENSE_SECRET)
        license_data = Base64.decode64(license_secret.dig('data', 'key.txt'))
        License.new(license_data)
      rescue ::KubernetesCLI::GetResourceError
        nil
      end

      def get_new_license
        auth = get_license_server_auth
        ns = kubernetes_cli.get_object('Namespace', KubeDB::NAMESPACE, KubeDB::NAMESPACE)
        cluster_id = ns.dig('metadata', 'uid')

        License.new(
          license_client.issue_license(
            name: auth.name,
            email_address: auth.email_address,
            cluster_id: cluster_id,
            token: auth.token
          )
        )
      end

      def renew_license_if_necessary(license)
        if license && !license.expired?
          Kuby.logger.info('Valid existing KubeDB license found')
        else
          if license && license.expired?
            Kuby.logger.info('KubeDB license has expired, automatically renewing')
          else
            Kuby.logger.info('No license found, fetching one from the license server')
          end

          license = get_new_license

          Kuby.logger.info('KubeDB license fetched successfully')
        end

        license
      end

      def get_license_server_auth
        if auth = get_license_server_auth_from_secret
          return auth
        end

        get_license_server_auth_from_user
      end

      def get_license_server_auth_from_secret
        token_secret = kubernetes_cli.get_object('Secret', KubeDB::NAMESPACE, LICENSE_SERVER_TOKEN_SECRET_NAME)

        name = Base64.decode64(token_secret.dig('data', 'name'))
        email_address = Base64.decode64(token_secret.dig('data', 'email_address'))
        token = Base64.decode64(token_secret.dig('data', 'token'))

        if [name, email_address, token].all? { |f| f && !f.strip.empty? }
          return LicenseServerAuth.new(name, email_address, token)
        end
      rescue ::KubernetesCLI::GetResourceError
        nil
      end

      def get_license_server_auth_from_user
        already_have_token = nil
        name = nil
        email_address = nil

        log_welcome_message_if_necessary

        loop do
          already_have_token = ask('Do you already have an AppsCode license server token, y/n?', 'n')

          case already_have_token
            when /\A[yY]/
              already_have_token = true
              break
            when /\A[nN]/
              already_have_token = false
              break
            else
              Kuby.logger.error('Please answer yes (y) or no (n)')
          end
        end

        return fetch_and_store_new_license_server_auth unless already_have_token

        token = ask_for_license_server_token
        log_welcome_message_if_necessary

        loop do
          Kuby.logger.info("Please enter the email address associated with your license server token.")
          email_address = ask('Email address', docker.credentials.email)

          if email_address.strip.empty?
            Kuby.logger.error('Email address required to continue')
            next
          end

          break
        end

        loop do
          Kuby.logger.info("Please enter the name associated with your license server token.")
          name = ask('Name')

          if name.strip.empty?
            Kuby.logger.error('Name required to continue')
            next
          end

          break
        end

        Kuby.logger.info('Storing license server token in cluster')
        store_license_server_token(name, email_address, token)
        Kuby.logger.info('License server token stored successfully in cluster')

        LicenseServerAuth.new(name, email_address, token)
      end

      def fetch_and_store_new_license_server_auth
        name = nil
        email_address = nil

        log_welcome_message_if_necessary

        loop do
          Kuby.logger.info("Please enter the name to register with AppsCode.")
          name = ask('Name')

          if name.strip.empty?
            Kuby.logger.error('Name required to continue')
            next
          end

          break
        end

        loop do
          Kuby.logger.info("Please enter the email address to register with AppsCode.")
          email_address = ask('Email address', docker.credentials.email)

          if email_address.strip.empty?
            Kuby.logger.error('Email address required to continue')
            next
          end

          break
        end

        Kuby.logger.info("Registering #{email_address} with AppsCode")
        license_client.register(email_address)
        Kuby.logger.info(
          "Registration succeeded! Please check your email for your AppsCode license server token\n"
        )

        token = ask_for_license_server_token

        Kuby.logger.info('Storing license server token in cluster')
        store_license_server_token(name, email_address, token)
        Kuby.logger.info('License server token stored successfully in cluster')

        LicenseServerAuth.new(name, email_address, token)
      end

      def store_license_server_token(name, email_address, token)
        token_secret = KubeDSL.secret do
          metadata do
            name LICENSE_SERVER_TOKEN_SECRET_NAME
            namespace KubeDB::NAMESPACE
          end

          type 'Opaque'

          data do
            add :name, name
            add :email_address, email_address
            add :token, token
          end
        end

        kubernetes_cli.apply(token_secret)
      end

      def ask_for_license_server_token
        loop do
          token = ask('License server token')

          if token.strip.empty?
            Kuby.logger.error('License server token required to continue')
            next
          end

          return token
        end
      end

      def log_welcome_message_if_necessary
        unless @welcome_message_logged
          Kuby.logger.info(
            "***************************************************************************\n"\
            "Kuby uses the community edition of the KubeDB operator to manage databases\n"\
            "in your Kubernetes cluster.\n"\
            "\n"\
            "As of version v2020.10.28, KubeDB requires a (free) license to operate. The\n"\
            "prompts that follow will register your email address with AppsCode (the makers\n"\
            "of KubeDB), automatically fetch a license, and install it into your cluster.\n"\
            "Licenses are valid for a period of 1 year. Kuby will automatically check and\n"\
            "potentially refresh your KubeDB license on every deploy.\n"
          )

          @welcome_message_logged = true
        end
      end

      def ask(prompt, default = nil)
        prompt = default ? "#{prompt} (#{default})" : prompt
        answer = Readline.readline("#{prompt}: ")
        answer.empty? && default ? default : answer
      end

      def license_client
        @license_client ||= AppscodeLicenseClient.new
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

      def docker
        environment.docker
      end
    end
  end
end
