module Kuby::KubeDB::DSL::API::V1
  class PrometheusSpec < ::KubeDSL::DSLObject
    key_value_field(:labels, format: :string)
    value_field :namespace
    value_field :port
    value_field :interval

    validates :labels, kv: { value_format: :string }, presence: true
    validates :namespace, field: { format: :string }, presence: false
    validates :port, field: { format: :integer }, presence: true
    validates :interval, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:labels] = labels.serialize
        result[:namespace] = namespace
        result[:port] = port
        result[:interval] = interval
      end
    end

    def kind_sym
      :prometheus_spec
    end
  end
end
