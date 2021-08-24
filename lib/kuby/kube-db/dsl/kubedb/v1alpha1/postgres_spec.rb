module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class PostgresSpec < ::KubeDSL::DSLObject
    object_field(:service_template) { Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { Kuby::KubeDB::DSL::API::V1::AgentSpec.new }
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
    object_field(:archiver) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::PostgresArchiverSpec.new }
    value_field :standby_mode
    object_field(:replica_service_template) { Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec.new }
    object_field(:leader_election) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::LeaderElectionConfig.new }
    object_field(:update_strategy) { KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy.new }
    value_field :streaming_mode

    validates :service_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec }
    validates :monitor, object: { kind_of: Kuby::KubeDB::DSL::API::V1::AgentSpec }
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
    validates :archiver, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::PostgresArchiverSpec }
    validates :standby_mode, field: { format: :string }, presence: false
    validates :replica_service_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec }
    validates :leader_election, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::LeaderElectionConfig }
    validates :update_strategy, object: { kind_of: KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy }
    validates :streaming_mode, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
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
        result[:archiver] = archiver.serialize
        result[:standbyMode] = standby_mode
        result[:replicaServiceTemplate] = replica_service_template.serialize
        result[:leaderElection] = leader_election.serialize
        result[:updateStrategy] = update_strategy.serialize
        result[:streamingMode] = streaming_mode
      end
    end

    def kind_sym
      :postgres_spec
    end
  end
end
