module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class RedisSpec < ::KubeDSL::DSLObject
    object_field(:service_template) { Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { Kuby::KubeDB::DSL::API::V1::AgentSpec.new }
    value_field :replicas
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    value_field :termination_policy
    object_field(:storage) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:config_source) { Kuby::KubeDB::DSL::V1::VolumeSource.new }
    object_field(:cluster) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::RedisClusterSpec.new }
    value_field :version
    value_field :storage_type
    value_field :mode
    object_field(:update_strategy) { KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy.new }

    validates :service_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec }
    validates :monitor, object: { kind_of: Kuby::KubeDB::DSL::API::V1::AgentSpec }
    validates :replicas, field: { format: :integer }, presence: true
    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :termination_policy, field: { format: :string }, presence: false
    validates :storage, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :config_source, object: { kind_of: Kuby::KubeDB::DSL::V1::VolumeSource }
    validates :cluster, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::RedisClusterSpec }
    validates :version, field: { format: :string }, presence: false
    validates :storage_type, field: { format: :string }, presence: false
    validates :mode, field: { format: :string }, presence: false
    validates :update_strategy, object: { kind_of: KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy }

    def serialize
      {}.tap do |result|
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
        result[:replicas] = replicas
        result[:podTemplate] = pod_template.serialize
        result[:terminationPolicy] = termination_policy
        result[:storage] = storage.serialize
        result[:configSource] = config_source.serialize
        result[:cluster] = cluster.serialize
        result[:version] = version
        result[:storageType] = storage_type
        result[:mode] = mode
        result[:updateStrategy] = update_strategy.serialize
      end
    end

    def kind_sym
      :redis_spec
    end
  end
end
