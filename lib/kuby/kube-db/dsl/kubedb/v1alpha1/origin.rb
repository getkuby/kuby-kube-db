module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class Origin < ::KubeDSL::DSLObject
    object_field(:spec) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::OriginSpec.new }
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ObjectMeta.new }

    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::OriginSpec }
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:spec] = spec.serialize
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :origin
    end
  end
end
