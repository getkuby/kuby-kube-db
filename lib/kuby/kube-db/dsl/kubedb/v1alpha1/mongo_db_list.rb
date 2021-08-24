module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDBList < ::KubeDSL::DSLObject
    array_field(:item) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDB.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ListMeta.new }

    validates :items, array: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDB }, presence: false
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ListMeta }

    def serialize
      {}.tap do |result|
        result[:items] = items.map(&:serialize)
        result[:kind] = "MongoDBList"
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :mongo_db_list
    end
  end
end
