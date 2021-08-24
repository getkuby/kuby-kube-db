module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class DatabaseAccessRequestCondition < ::KubeDSL::DSLObject
    value_field :message
    value_field :type
    value_field :reason
    value_field :last_update_time

    validates :message, field: { format: :string }, presence: false
    validates :type, field: { format: :string }, presence: false
    validates :reason, field: { format: :string }, presence: false
    validates :last_update_time, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:message] = message
        result[:type] = type
        result[:reason] = reason
        result[:lastUpdateTime] = last_update_time
      end
    end

    def kind_sym
      :database_access_request_condition
    end
  end
end
