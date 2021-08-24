module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class MongoDBRoleSpec < ::KubeDSL::DSLObject
    object_field(:auth_manager_ref) { Kuby::KubeDB::DSL::Appcatalog::V1alpha1::AppReference.new }
    object_field(:database_ref) { KubeDSL::DSL::V1::LocalObjectReference.new }
    value_field :revocation_statements
    value_field :creation_statements
    value_field :max_ttl
    value_field :default_ttl

    validates :auth_manager_ref, object: { kind_of: Kuby::KubeDB::DSL::Appcatalog::V1alpha1::AppReference }
    validates :database_ref, object: { kind_of: KubeDSL::DSL::V1::LocalObjectReference }
    validates :revocation_statements, field: { format: :string }, presence: false
    validates :creation_statements, field: { format: :string }, presence: false
    validates :max_ttl, field: { format: :string }, presence: false
    validates :default_ttl, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:authManagerRef] = auth_manager_ref.serialize
        result[:databaseRef] = database_ref.serialize
        result[:revocationStatements] = revocation_statements
        result[:creationStatements] = creation_statements
        result[:maxTTL] = max_ttl
        result[:defaultTTL] = default_ttl
      end
    end

    def kind_sym
      :mongo_db_role_spec
    end
  end
end
