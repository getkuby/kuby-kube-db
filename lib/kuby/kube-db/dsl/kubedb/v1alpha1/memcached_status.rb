module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MemcachedStatus < ::KubeDSL::DSLObject
    value_fields :observed_generation, :phase, :reason

    def serialize
      {}.tap do |result|
        result[:observedGeneration] = observed_generation
        result[:phase] = phase
        result[:reason] = reason
      end
    end

    def kind_sym
      :memcached_status
    end
  end
end
