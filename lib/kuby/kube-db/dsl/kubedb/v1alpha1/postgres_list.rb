module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class PostgresList < ::KubeDSL::DSLObject
    array_field(:item) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::Postgres.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ListMeta.new }

    validates :items, array: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::Postgres }, presence: false
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ListMeta }

    def serialize
      {}.tap do |result|
        result[:items] = items.map(&:serialize)
        result[:kind] = "PostgresList"
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :postgres_list
    end
  end
end
