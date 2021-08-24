module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class DormantDatabaseStatus < ::KubeDSL::DSLObject
    value_field :observed_generation
    value_field :phase
    value_field :reason
    value_field :wipe_out_time
    value_field :pausing_time

    validates :observed_generation, field: { format: :string }, presence: false
    validates :phase, field: { format: :string }, presence: false
    validates :reason, field: { format: :string }, presence: false
    validates :wipe_out_time, field: { format: :string }, presence: false
    validates :pausing_time, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:observedGeneration] = observed_generation
        result[:phase] = phase
        result[:reason] = reason
        result[:wipeOutTime] = wipe_out_time
        result[:pausingTime] = pausing_time
      end
    end

    def kind_sym
      :dormant_database_status
    end
  end
end
