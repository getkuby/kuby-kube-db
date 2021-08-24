module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class MySQLRoleCondition < ::KubeDSL::DSLObject
    value_field :status
    value_field :message
    value_field :type
    value_field :reason

    validates :status, field: { format: :string }, presence: false
    validates :message, field: { format: :string }, presence: false
    validates :type, field: { format: :string }, presence: false
    validates :reason, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:status] = status
        result[:message] = message
        result[:type] = type
        result[:reason] = reason
      end
    end

    def kind_sym
      :my_sql_role_condition
    end
  end
end
