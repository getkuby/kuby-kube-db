module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class MongoDBRoleStatus < ::KubeDSL::DSLObject
    value_field :observed_generation
    value_field :phase
    array_field(:condition) { Kuby::KubeDB::DSL::Authorization::V1alpha1::MongoDBRoleCondition.new }

    validates :observed_generation, field: { format: :string }, presence: false
    validates :phase, field: { format: :string }, presence: false
    validates :conditions, array: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::MongoDBRoleCondition }, presence: false

    def serialize
      {}.tap do |result|
        result[:observedGeneration] = observed_generation
        result[:phase] = phase
        result[:conditions] = conditions.map(&:serialize)
      end
    end

    def kind_sym
      :mongo_db_role_status
    end
  end
end
