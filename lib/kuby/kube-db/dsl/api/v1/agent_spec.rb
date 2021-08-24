module Kuby::KubeDB::DSL::API::V1
  class AgentSpec < ::KubeDSL::DSLObject
    object_field(:security_context) { KubeDSL::DSL::V1::SecurityContext.new }
    value_field :args
    value_field :agent
    object_field(:prometheus) { Kuby::KubeDB::DSL::API::V1::PrometheusSpec.new }
    array_field(:env) { KubeDSL::DSL::V1::EnvVar.new }
    object_field(:resources) { KubeDSL::DSL::V1::ResourceRequirements.new }

    validates :security_context, object: { kind_of: KubeDSL::DSL::V1::SecurityContext }
    validates :args, field: { format: :string }, presence: false
    validates :agent, field: { format: :string }, presence: false
    validates :prometheus, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PrometheusSpec }
    validates :envs, array: { kind_of: KubeDSL::DSL::V1::EnvVar }, presence: false
    validates :resources, object: { kind_of: KubeDSL::DSL::V1::ResourceRequirements }

    def serialize
      {}.tap do |result|
        result[:securityContext] = security_context.serialize
        result[:args] = args
        result[:agent] = agent
        result[:prometheus] = prometheus.serialize
        result[:env] = envs.map(&:serialize)
        result[:resources] = resources.serialize
      end
    end

    def kind_sym
      :agent_spec
    end
  end
end
