module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MemberSecret < ::KubeDSL::DSLObject
    value_field :peer_secret
    value_field :server_secret

    validates :peer_secret, field: { format: :string }, presence: false
    validates :server_secret, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:peerSecret] = peer_secret
        result[:serverSecret] = server_secret
      end
    end

    def kind_sym
      :member_secret
    end
  end
end
