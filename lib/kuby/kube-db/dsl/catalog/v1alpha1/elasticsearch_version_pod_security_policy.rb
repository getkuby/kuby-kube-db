module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class ElasticsearchVersionPodSecurityPolicy < ::KubeDSL::DSLObject
    value_field :snapshotter_policy_name
    value_field :database_policy_name

    validates :snapshotter_policy_name, field: { format: :string }, presence: false
    validates :database_policy_name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:snapshotterPolicyName] = snapshotter_policy_name
        result[:databasePolicyName] = database_policy_name
      end
    end

    def kind_sym
      :elasticsearch_version_pod_security_policy
    end
  end
end
