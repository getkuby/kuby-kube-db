module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class LeaderElectionConfig < ::KubeDSL::DSLObject
    value_field :lease_duration_seconds
    value_field :renew_deadline_seconds
    value_field :retry_period_seconds

    validates :lease_duration_seconds, field: { format: :integer }, presence: true
    validates :renew_deadline_seconds, field: { format: :integer }, presence: true
    validates :retry_period_seconds, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:leaseDurationSeconds] = lease_duration_seconds
        result[:renewDeadlineSeconds] = renew_deadline_seconds
        result[:retryPeriodSeconds] = retry_period_seconds
      end
    end

    def kind_sym
      :leader_election_config
    end
  end
end
