module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDB < ::KubeDSL::DSLObject
    object_field(:status) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBStatus.new }
    object_field(:spec) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBSpec.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ObjectMeta.new }

    validates :status, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBStatus }
    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBSpec }
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:status] = status.serialize
        result[:kind] = "MongoDB"
        result[:spec] = spec.serialize
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :mongo_db
    end
  end
end
