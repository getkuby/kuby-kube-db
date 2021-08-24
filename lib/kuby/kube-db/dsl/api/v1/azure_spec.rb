module Kuby::KubeDB::DSL::API::V1
  class AzureSpec < ::KubeDSL::DSLObject
    value_field :prefix
    value_field :container
    value_field :max_connections

    validates :prefix, field: { format: :string }, presence: false
    validates :container, field: { format: :string }, presence: false
    validates :max_connections, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:prefix] = prefix
        result[:container] = container
        result[:maxConnections] = max_connections
      end
    end

    def kind_sym
      :azure_spec
    end
  end
end
