module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class PostgresVersionList < ::KubeDSL::DSLObject
    array_field(:item) { Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersion.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ListMeta.new }

    validates :items, array: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersion }, presence: false
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ListMeta }

    def serialize
      {}.tap do |result|
        result[:items] = items.map(&:serialize)
        result[:kind] = "PostgresVersionList"
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :postgres_version_list
    end
  end
end
