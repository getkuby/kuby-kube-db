module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class PostgresVersion < ::KubeDSL::DSLObject
    object_field(:spec) { Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionSpec.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ObjectMeta.new }

    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionSpec }
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:kind] = "PostgresVersion"
        result[:spec] = spec.serialize
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :postgres_version
    end
  end
end
