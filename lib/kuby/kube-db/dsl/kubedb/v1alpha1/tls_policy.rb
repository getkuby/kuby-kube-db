module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class TLSPolicy < ::KubeDSL::DSLObject
    object_field(:member) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MemberSecret.new }
    value_field :operator_secret

    validates :member, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MemberSecret }
    validates :operator_secret, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:member] = member.serialize
        result[:operatorSecret] = operator_secret
      end
    end

    def kind_sym
      :tls_policy
    end
  end
end
