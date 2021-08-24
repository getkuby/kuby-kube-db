module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class DatabaseAccessRequestSpec < ::KubeDSL::DSLObject
    object_field(:role_ref) { Kuby::KubeDB::DSL::Authorization::V1alpha1::RoleReference.new }
    array_field(:subject) { KubeDSL::DSL::Rbac::V1::Subject.new }
    value_field :ttl

    validates :role_ref, object: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::RoleReference }
    validates :subjects, array: { kind_of: KubeDSL::DSL::Rbac::V1::Subject }, presence: false
    validates :ttl, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:roleRef] = role_ref.serialize
        result[:subjects] = subjects.map(&:serialize)
        result[:ttl] = ttl
      end
    end

    def kind_sym
      :database_access_request_spec
    end
  end
end
