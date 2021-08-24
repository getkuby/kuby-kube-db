module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDBConfigNode < ::KubeDSL::DSLObject
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    value_field :prefix
    object_field(:storage) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:config_source) { Kuby::KubeDB::DSL::V1::VolumeSource.new }
    value_field :replicas

    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :prefix, field: { format: :string }, presence: false
    validates :storage, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :config_source, object: { kind_of: Kuby::KubeDB::DSL::V1::VolumeSource }
    validates :replicas, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:podTemplate] = pod_template.serialize
        result[:prefix] = prefix
        result[:storage] = storage.serialize
        result[:configSource] = config_source.serialize
        result[:replicas] = replicas
      end
    end

    def kind_sym
      :mongo_db_config_node
    end
  end
end
