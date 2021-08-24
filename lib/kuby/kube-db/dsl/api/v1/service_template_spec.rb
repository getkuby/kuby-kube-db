module Kuby::KubeDB::DSL::API::V1
  class ServiceTemplateSpec < ::KubeDSL::DSLObject
    object_field(:spec) { Kuby::KubeDB::DSL::API::V1::ServiceSpec.new }
    object_field(:metadata) { Kuby::KubeDB::DSL::API::V1::ObjectMeta.new }

    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ServiceSpec }
    validates :metadata, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:spec] = spec.serialize
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :service_template_spec
    end
  end
end
