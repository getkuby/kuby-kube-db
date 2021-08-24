module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class MemcachedVersionPodSecurityPolicy < ::KubeDSL::DSLObject
    value_field :database_policy_name

    validates :database_policy_name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:databasePolicyName] = database_policy_name
      end
    end

    def kind_sym
      :memcached_version_pod_security_policy
    end
  end
end
