module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class DormantDatabaseSpec < ::KubeDSL::DSLObject
    object_field(:origin) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::Origin.new }
    value_field :wipe_out

    validates :origin, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::Origin }
    validates :wipe_out, field: { format: :boolean }, presence: true

    def serialize
      {}.tap do |result|
        result[:origin] = origin.serialize
        result[:wipeOut] = wipe_out
      end
    end

    def kind_sym
      :dormant_database_spec
    end
  end
end
