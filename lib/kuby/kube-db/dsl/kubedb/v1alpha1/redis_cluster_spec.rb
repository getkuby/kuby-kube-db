module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class RedisClusterSpec < ::KubeDSL::DSLObject
    value_field :master
    value_field :replicas

    validates :master, field: { format: :integer }, presence: true
    validates :replicas, field: { format: :integer }, presence: true

    def serialize
      {}.tap do |result|
        result[:master] = master
        result[:replicas] = replicas
      end
    end

    def kind_sym
      :redis_cluster_spec
    end
  end
end
