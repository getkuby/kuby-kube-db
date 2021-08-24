module Kuby::KubeDB::DSL::API::V1
  class PodSpec < ::KubeDSL::DSLObject
    value_field :priority_class_name
    object_field(:liveness_probe) { KubeDSL::DSL::V1::Probe.new }
    object_field(:security_context) { KubeDSL::DSL::V1::PodSecurityContext.new }
    value_field :service_account_name
    value_field :scheduler_name
    value_field :args
    key_value_field(:node_selector, format: :string)
    value_field :priority
    object_field(:affinity) { KubeDSL::DSL::V1::Affinity.new }
    array_field(:env) { KubeDSL::DSL::V1::EnvVar.new }
    object_field(:readiness_probe) { KubeDSL::DSL::V1::Probe.new }
    array_field(:toleration) { KubeDSL::DSL::V1::Toleration.new }
    array_field(:init_container) { KubeDSL::DSL::V1::Container.new }
    object_field(:lifecycle) { KubeDSL::DSL::V1::Lifecycle.new }
    object_field(:resources) { KubeDSL::DSL::V1::ResourceRequirements.new }
    array_field(:image_pull_secret) { KubeDSL::DSL::V1::LocalObjectReference.new }

    validates :priority_class_name, field: { format: :string }, presence: false
    validates :liveness_probe, object: { kind_of: KubeDSL::DSL::V1::Probe }
    validates :security_context, object: { kind_of: KubeDSL::DSL::V1::PodSecurityContext }
    validates :service_account_name, field: { format: :string }, presence: false
    validates :scheduler_name, field: { format: :string }, presence: false
    validates :args, field: { format: :string }, presence: false
    validates :node_selector, kv: { value_format: :string }, presence: true
    validates :priority, field: { format: :integer }, presence: true
    validates :affinity, object: { kind_of: KubeDSL::DSL::V1::Affinity }
    validates :envs, array: { kind_of: KubeDSL::DSL::V1::EnvVar }, presence: false
    validates :readiness_probe, object: { kind_of: KubeDSL::DSL::V1::Probe }
    validates :tolerations, array: { kind_of: KubeDSL::DSL::V1::Toleration }, presence: false
    validates :init_containers, array: { kind_of: KubeDSL::DSL::V1::Container }, presence: false
    validates :lifecycle, object: { kind_of: KubeDSL::DSL::V1::Lifecycle }
    validates :resources, object: { kind_of: KubeDSL::DSL::V1::ResourceRequirements }
    validates :image_pull_secrets, array: { kind_of: KubeDSL::DSL::V1::LocalObjectReference }, presence: false

    def serialize
      {}.tap do |result|
        result[:priorityClassName] = priority_class_name
        result[:livenessProbe] = liveness_probe.serialize
        result[:securityContext] = security_context.serialize
        result[:serviceAccountName] = service_account_name
        result[:schedulerName] = scheduler_name
        result[:args] = args
        result[:nodeSelector] = node_selector.serialize
        result[:priority] = priority
        result[:affinity] = affinity.serialize
        result[:env] = envs.map(&:serialize)
        result[:readinessProbe] = readiness_probe.serialize
        result[:tolerations] = tolerations.map(&:serialize)
        result[:initContainers] = init_containers.map(&:serialize)
        result[:lifecycle] = lifecycle.serialize
        result[:resources] = resources.serialize
        result[:imagePullSecrets] = image_pull_secrets.map(&:serialize)
      end
    end

    def kind_sym
      :pod_spec
    end
  end
end
