module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class DormantDatabase < ::KubeDSL::DSLObject
    object_field(:status) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::DormantDatabaseStatus.new }
    object_field(:spec) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::DormantDatabaseSpec.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ObjectMeta.new }

    validates :status, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::DormantDatabaseStatus }
    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::DormantDatabaseSpec }
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:status] = status.serialize
        result[:kind] = "DormantDatabase"
        result[:spec] = spec.serialize
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :dormant_database
    end
  end
end
