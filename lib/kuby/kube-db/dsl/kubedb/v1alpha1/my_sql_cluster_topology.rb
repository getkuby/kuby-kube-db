module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MySQLClusterTopology < ::KubeDSL::DSLObject
    object_field(:group) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MySQLGroupSpec.new }
    value_field :mode

    validates :group, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MySQLGroupSpec }
    validates :mode, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:group] = group.serialize
        result[:mode] = mode
      end
    end

    def kind_sym
      :my_sql_cluster_topology
    end
  end
end
