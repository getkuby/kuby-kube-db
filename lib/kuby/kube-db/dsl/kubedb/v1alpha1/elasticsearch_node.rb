module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class ElasticsearchNode < ::KubeDSL::DSLObject
    value_field :prefix
    object_field(:storage) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:resources) { KubeDSL::DSL::V1::ResourceRequirements.new }
    value_field :replicas

    validates :prefix, field: { format: :string }, presence: false
    validates :storage, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :resources, object: { kind_of: KubeDSL::DSL::V1::ResourceRequirements }
    validates :replicas, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:prefix] = prefix
        result[:storage] = storage.serialize
        result[:resources] = resources.serialize
        result[:replicas] = replicas
      end
    end

    def kind_sym
      :elasticsearch_node
    end
  end
end
