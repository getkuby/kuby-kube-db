module Kuby::KubeDB::DSL::API::V1
  class GCSSpec < ::KubeDSL::DSLObject
    value_field :prefix
    value_field :bucket
    value_field :max_connections

    validates :prefix, field: { format: :string }, presence: false
    validates :bucket, field: { format: :string }, presence: false
    validates :max_connections, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:prefix] = prefix
        result[:bucket] = bucket
        result[:maxConnections] = max_connections
      end
    end

    def kind_sym
      :gcs_spec
    end
  end
end
