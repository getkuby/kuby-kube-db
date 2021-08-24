module Kuby::KubeDB::DSL::API::V1
  class ObjectMeta < ::KubeDSL::DSLObject
    key_value_field(:annotations, format: :string)

    validates :annotations, kv: { value_format: :string }, presence: true

    def serialize
      {}.tap do |result|
        result[:annotations] = annotations.serialize
      end
    end

    def kind_sym
      :object_meta
    end
  end
end
