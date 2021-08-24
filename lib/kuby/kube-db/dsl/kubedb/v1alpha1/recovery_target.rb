module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class RecoveryTarget < ::KubeDSL::DSLObject
    value_field :target_inclusive
    value_field :target_timeline
    value_field :target_time
    value_field :target_xid

    validates :target_inclusive, field: { format: :boolean }, presence: true
    validates :target_timeline, field: { format: :string }, presence: false
    validates :target_time, field: { format: :string }, presence: false
    validates :target_xid, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:targetInclusive] = target_inclusive
        result[:targetTimeline] = target_timeline
        result[:targetTime] = target_time
        result[:targetXID] = target_xid
      end
    end

    def kind_sym
      :recovery_target
    end
  end
end
