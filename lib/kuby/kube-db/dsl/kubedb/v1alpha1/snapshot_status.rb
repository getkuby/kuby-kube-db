module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class SnapshotStatus < ::KubeDSL::DSLObject
    value_field :observed_generation
    value_field :phase
    value_field :reason
    value_field :completion_time
    value_field :start_time

    validates :observed_generation, field: { format: :string }, presence: false
    validates :phase, field: { format: :string }, presence: false
    validates :reason, field: { format: :string }, presence: false
    validates :completion_time, field: { format: :string }, presence: false
    validates :start_time, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:observedGeneration] = observed_generation
        result[:phase] = phase
        result[:reason] = reason
        result[:completionTime] = completion_time
        result[:startTime] = start_time
      end
    end

    def kind_sym
      :snapshot_status
    end
  end
end
