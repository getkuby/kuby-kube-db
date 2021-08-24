module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class EtcdSpec < ::KubeDSL::DSLObject
    object_field(:tls) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::TLSPolicy.new }
    object_field(:service_template) { Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec.new }
    object_field(:monitor) { Kuby::KubeDB::DSL::API::V1::AgentSpec.new }
    value_field :replicas
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    value_field :termination_policy
    object_field(:backup_schedule) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::BackupScheduleSpec.new }
    object_field(:storage) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:database_secret) { KubeDSL::DSL::V1::SecretVolumeSource.new }
    value_field :storage_type
    object_field(:init) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::InitSpec.new }
    value_field :version
    object_field(:update_strategy) { KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy.new }

    validates :tls, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::TLSPolicy }
    validates :service_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceTemplateSpec }
    validates :monitor, object: { kind_of: Kuby::KubeDB::DSL::API::V1::AgentSpec }
    validates :replicas, field: { format: :integer }, presence: true
    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :termination_policy, field: { format: :string }, presence: false
    validates :backup_schedule, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::BackupScheduleSpec }
    validates :storage, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :database_secret, object: { kind_of: KubeDSL::DSL::V1::SecretVolumeSource }
    validates :storage_type, field: { format: :string }, presence: false
    validates :init, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::InitSpec }
    validates :version, field: { format: :string }, presence: false
    validates :update_strategy, object: { kind_of: KubeDSL::DSL::Apps::V1::StatefulSetUpdateStrategy }

    def serialize
      {}.tap do |result|
        result[:tls] = tls.serialize
        result[:serviceTemplate] = service_template.serialize
        result[:monitor] = monitor.serialize
        result[:replicas] = replicas
        result[:podTemplate] = pod_template.serialize
        result[:terminationPolicy] = termination_policy
        result[:backupSchedule] = backup_schedule.serialize
        result[:storage] = storage.serialize
        result[:databaseSecret] = database_secret.serialize
        result[:storageType] = storage_type
        result[:init] = init.serialize
        result[:version] = version
        result[:updateStrategy] = update_strategy.serialize
      end
    end

    def kind_sym
      :etcd_spec
    end
  end
end
