module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MemcachedSpec < ::KubeDSL::DSLObject
    value_fields :replicas, :termination_policy, :version
    object_field(:service_template) { Kuby::KubeDB::DSL::Api::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { Kuby::KubeDB::DSL::Api::V1::AgentSpec.new }
    object_field(:pod_template) { Kuby::KubeDB::DSL::Api::V1::PodTemplateSpec.new }
    object_field(:config_source) { Kuby::KubeDB::DSL::V1::VolumeSource.new }
    object_field(:strategy) { KubeDSL::DSL::Apps::V1::DeploymentStrategy.new }

    def serialize
      {}.tap do |result|
        result[:replicas] = replicas
        result[:terminationPolicy] = termination_policy
        result[:version] = version
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
        result[:podTemplate] = pod_template.serialize
        result[:configSource] = config_source.serialize
        result[:strategy] = strategy.serialize
      end
    end

    def kind_sym
      :memcached_spec
    end
  end
end
