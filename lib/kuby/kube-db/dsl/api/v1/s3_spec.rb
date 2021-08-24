module Kuby::KubeDB::DSL::API::V1
  class S3Spec < ::KubeDSL::DSLObject
    value_field :prefix
    value_field :endpoint
    value_field :bucket

    validates :prefix, field: { format: :string }, presence: false
    validates :endpoint, field: { format: :string }, presence: false
    validates :bucket, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:prefix] = prefix
        result[:endpoint] = endpoint
        result[:bucket] = bucket
      end
    end

    def kind_sym
      :s3_spec
    end
  end
end
