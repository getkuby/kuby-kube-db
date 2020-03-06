module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class ProxySQLSpec < ::KubeDSL::DSLObject
    value_fields :replicas, :paused, :version, :mode
    object_field(:tls) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::TLSConfig.new }
    object_field(:service_template) { KubeDSL::DSL::Api::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { KubeDSL::DSL::Api::V1::AgentSpec.new }
    object_field(:pod_template) { KubeDSL::DSL::Api::V1::PodTemplateSpec.new }
    object_field(:config_source) { KubeDSL::DSL::V1::VolumeSource.new }
    object_field(:proxysql_secret) { KubeDSL::DSL::V1::SecretVolumeSource.new }
    object_field(:update_strategy) { KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy.new }
    object_field(:backend) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::ProxySQLBackendSpec.new }

    def serialize
      {}.tap do |result|
        result[:replicas] = replicas
        result[:paused] = paused
        result[:version] = version
        result[:mode] = mode
        result[:tls] = tls.serialize
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
        result[:podTemplate] = pod_template.serialize
        result[:configSource] = config_source.serialize
        result[:proxysqlSecret] = proxysql_secret.serialize
        result[:updateStrategy] = update_strategy.serialize
        result[:backend] = backend.serialize
      end
    end

    def kind
      :proxy_sql_spec
    end
  end
end