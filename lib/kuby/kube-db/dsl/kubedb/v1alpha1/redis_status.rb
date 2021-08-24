module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class RedisStatus < ::KubeDSL::DSLObject
    value_field :observed_generation
    value_field :phase
    value_field :reason

    validates :observed_generation, field: { format: :string }, presence: false
    validates :phase, field: { format: :string }, presence: false
    validates :reason, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:observedGeneration] = observed_generation
        result[:phase] = phase
        result[:reason] = reason
      end
    end

    def kind_sym
      :redis_status
    end
  end
end
