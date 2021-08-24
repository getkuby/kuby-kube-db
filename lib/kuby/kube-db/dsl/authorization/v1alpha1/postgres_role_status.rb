module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class PostgresRoleStatus < ::KubeDSL::DSLObject
    value_field :observed_generation
    value_field :phase
    array_field(:condition) { Kuby::KubeDB::DSL::Authorization::V1alpha1::PostgresRoleCondition.new }

    validates :observed_generation, field: { format: :string }, presence: false
    validates :phase, field: { format: :string }, presence: false
    validates :conditions, array: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::PostgresRoleCondition }, presence: false

    def serialize
      {}.tap do |result|
        result[:observedGeneration] = observed_generation
        result[:phase] = phase
        result[:conditions] = conditions.map(&:serialize)
      end
    end

    def kind_sym
      :postgres_role_status
    end
  end
end
