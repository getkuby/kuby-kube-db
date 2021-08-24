module Kuby::KubeDB::DSL::API::V1
  class SwiftSpec < ::KubeDSL::DSLObject
    value_field :prefix
    value_field :container

    validates :prefix, field: { format: :string }, presence: false
    validates :container, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:prefix] = prefix
        result[:container] = container
      end
    end

    def kind_sym
      :swift_spec
    end
  end
end
