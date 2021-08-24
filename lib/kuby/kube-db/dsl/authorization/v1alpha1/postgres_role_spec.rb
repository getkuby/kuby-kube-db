module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class PostgresRoleSpec < ::KubeDSL::DSLObject
    object_field(:auth_manager_ref) { Kuby::KubeDB::DSL::Appcatalog::V1alpha1::AppReference.new }
    value_field :rollback_statements
    object_field(:database_ref) { KubeDSL::DSL::V1::LocalObjectReference.new }
    value_field :revocation_statements
    value_field :creation_statements
    value_field :max_ttl
    value_field :renew_statements
    value_field :default_ttl

    validates :auth_manager_ref, object: { kind_of: Kuby::KubeDB::DSL::Appcatalog::V1alpha1::AppReference }
    validates :rollback_statements, field: { format: :string }, presence: false
    validates :database_ref, object: { kind_of: KubeDSL::DSL::V1::LocalObjectReference }
    validates :revocation_statements, field: { format: :string }, presence: false
    validates :creation_statements, field: { format: :string }, presence: false
    validates :max_ttl, field: { format: :string }, presence: false
    validates :renew_statements, field: { format: :string }, presence: false
    validates :default_ttl, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:authManagerRef] = auth_manager_ref.serialize
        result[:rollbackStatements] = rollback_statements
        result[:databaseRef] = database_ref.serialize
        result[:revocationStatements] = revocation_statements
        result[:creationStatements] = creation_statements
        result[:maxTTL] = max_ttl
        result[:renewStatements] = renew_statements
        result[:defaultTTL] = default_ttl
      end
    end

    def kind_sym
      :postgres_role_spec
    end
  end
end
