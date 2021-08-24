module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MemcachedSpec < ::KubeDSL::DSLObject
    object_field(:service_template) { Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { Kuby::KubeDB::DSL::API::V1::AgentSpec.new }
    value_field :replicas
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    value_field :termination_policy
    object_field(:config_source) { Kuby::KubeDB::DSL::V1::VolumeSource.new }
    object_field(:strategy) { KubeDSL::DSL::Apps::V1::DeploymentStrategy.new }
    value_field :version

    validates :service_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec }
    validates :monitor, object: { kind_of: Kuby::KubeDB::DSL::API::V1::AgentSpec }
    validates :replicas, field: { format: :integer }, presence: true
    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :termination_policy, field: { format: :string }, presence: false
    validates :config_source, object: { kind_of: Kuby::KubeDB::DSL::V1::VolumeSource }
    validates :strategy, object: { kind_of: KubeDSL::DSL::Apps::V1::DeploymentStrategy }
    validates :version, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
        result[:replicas] = replicas
        result[:podTemplate] = pod_template.serialize
        result[:terminationPolicy] = termination_policy
        result[:configSource] = config_source.serialize
        result[:strategy] = strategy.serialize
        result[:version] = version
      end
    end

    def kind_sym
      :memcached_spec
    end
  end
end
