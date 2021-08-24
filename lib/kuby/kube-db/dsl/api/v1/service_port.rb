module Kuby::KubeDB::DSL::API::V1
  class ServicePort < ::KubeDSL::DSLObject
    value_field :port
    value_field :name
    value_field :node_port

    validates :port, field: { format: :integer }, presence: true
    validates :name, field: { format: :string }, presence: false
    validates :node_port, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:port] = port
        result[:name] = name
        result[:nodePort] = node_port
      end
    end

    def kind_sym
      :service_port
    end
  end
end
