module Kuby::KubeDB::DSL::API::V1
  class PodTemplateSpec < ::KubeDSL::DSLObject
    object_field(:controller) { Kuby::KubeDB::DSL::API::V1::ObjectMeta.new }
    object_field(:spec) { Kuby::KubeDB::DSL::API::V1::PodSpec.new }
    object_field(:metadata) { Kuby::KubeDB::DSL::API::V1::ObjectMeta.new }

    validates :controller, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ObjectMeta }
    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodSpec }
    validates :metadata, object: { kind_of: Kuby::KubeDB::DSL::API::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:controller] = controller.serialize
        result[:spec] = spec.serialize
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :pod_template_spec
    end
  end
end
