module Kuby::KubeDB::DSL::API::V1
  class ServiceSpec < ::KubeDSL::DSLObject
    value_field :load_balancer_ip
    value_field :external_i_ps
    value_field :type
    value_field :external_traffic_policy
    value_field :cluster_ip
    value_field :load_balancer_source_ranges
    value_field :health_check_node_port
    array_field(:port) { Kuby::KubeDB::DSL::API::V1::ServicePort.new }

    validates :load_balancer_ip, field: { format: :string }, presence: false
    validates :external_i_ps, field: { format: :string }, presence: false
    validates :type, field: { format: :string }, presence: false
    validates :external_traffic_policy, field: { format: :string }, presence: false
    validates :cluster_ip, field: { format: :string }, presence: false
    validates :load_balancer_source_ranges, field: { format: :string }, presence: false
    validates :health_check_node_port, field: { format: :integer }, presence: true
    validates :ports, array: { kind_of: Kuby::KubeDB::DSL::API::V1::ServicePort }, presence: false

    def serialize
      {}.tap do |result|
        result[:loadBalancerIP] = load_balancer_ip
        result[:externalIPs] = external_i_ps
        result[:type] = type
        result[:externalTrafficPolicy] = external_traffic_policy
        result[:clusterIP] = cluster_ip
        result[:loadBalancerSourceRanges] = load_balancer_source_ranges
        result[:healthCheckNodePort] = health_check_node_port
        result[:ports] = ports.map(&:serialize)
      end
    end

    def kind_sym
      :service_spec
    end
  end
end
