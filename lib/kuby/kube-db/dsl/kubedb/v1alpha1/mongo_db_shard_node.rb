module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDBShardNode < ::KubeDSL::DSLObject
    value_field :replicas
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    object_field(:storage) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:config_source) { Kuby::KubeDB::DSL::V1::VolumeSource.new }
    value_field :shards
    value_field :prefix

    validates :replicas, field: { format: :integer }, presence: true
    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :storage, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :config_source, object: { kind_of: Kuby::KubeDB::DSL::V1::VolumeSource }
    validates :shards, field: { format: :integer }, presence: true
    validates :prefix, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:replicas] = replicas
        result[:podTemplate] = pod_template.serialize
        result[:storage] = storage.serialize
        result[:configSource] = config_source.serialize
        result[:shards] = shards
        result[:prefix] = prefix
      end
    end

    def kind_sym
      :mongo_db_shard_node
    end
  end
end
