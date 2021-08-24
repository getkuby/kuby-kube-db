module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDBSpec < ::KubeDSL::DSLObject
    object_field(:shard_topology) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBShardingTopology.new }
    object_field(:service_template) { Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { Kuby::KubeDB::DSL::API::V1::AgentSpec.new }
    object_field(:replica_set) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBReplicaSet.new }
    value_field :replicas
    value_field :storage_type
    value_field :termination_policy
    object_field(:backup_schedule) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::BackupScheduleSpec.new }
    object_field(:storage) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:config_source) { Kuby::KubeDB::DSL::V1::VolumeSource.new }
    object_field(:database_secret) { KubeDSL::DSL::V1::SecretVolumeSource.new }
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    object_field(:init) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::InitSpec.new }
    value_field :version
    object_field(:certificate_secret) { KubeDSL::DSL::V1::SecretVolumeSource.new }
    object_field(:update_strategy) { KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy.new }

    validates :shard_topology, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBShardingTopology }
    validates :service_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec }
    validates :monitor, object: { kind_of: Kuby::KubeDB::DSL::API::V1::AgentSpec }
    validates :replica_set, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBReplicaSet }
    validates :replicas, field: { format: :integer }, presence: true
    validates :storage_type, field: { format: :string }, presence: false
    validates :termination_policy, field: { format: :string }, presence: false
    validates :backup_schedule, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::BackupScheduleSpec }
    validates :storage, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :config_source, object: { kind_of: Kuby::KubeDB::DSL::V1::VolumeSource }
    validates :database_secret, object: { kind_of: KubeDSL::DSL::V1::SecretVolumeSource }
    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :init, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::InitSpec }
    validates :version, field: { format: :string }, presence: false
    validates :certificate_secret, object: { kind_of: KubeDSL::DSL::V1::SecretVolumeSource }
    validates :update_strategy, object: { kind_of: KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy }

    def serialize
      {}.tap do |result|
        result[:shardTopology] = shard_topology.serialize
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
        result[:replicaSet] = replica_set.serialize
        result[:replicas] = replicas
        result[:storageType] = storage_type
        result[:terminationPolicy] = termination_policy
        result[:backupSchedule] = backup_schedule.serialize
        result[:storage] = storage.serialize
        result[:configSource] = config_source.serialize
        result[:databaseSecret] = database_secret.serialize
        result[:podTemplate] = pod_template.serialize
        result[:init] = init.serialize
        result[:version] = version
        result[:certificateSecret] = certificate_secret.serialize
        result[:updateStrategy] = update_strategy.serialize
      end
    end

    def kind_sym
      :mongo_db_spec
    end
  end
end
