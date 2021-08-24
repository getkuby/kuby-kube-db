module Kuby::KubeDB::DSL::Meta::V1
  class Initializers < ::KubeDSL::DSLObject
    object_field(:result) { KubeDSL::DSL::Meta::V1::Status.new }
    array_field(:pending) { Kuby::KubeDB::DSL::Meta::V1::Initializer.new }

    validates :result, object: { kind_of: KubeDSL::DSL::Meta::V1::Status }
    validates :pendings, array: { kind_of: Kuby::KubeDB::DSL::Meta::V1::Initializer }, presence: false

    def serialize
      {}.tap do |result|
        result[:result] = result.serialize
        result[:pending] = pendings.map(&:serialize)
      end
    end

    def kind_sym
      :initializers
    end
  end
end
