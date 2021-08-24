module Kuby::KubeDB::DSL::Meta::V1
  class Initializer < ::KubeDSL::DSLObject
    value_field :name

    validates :name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:name] = name
      end
    end

    def kind_sym
      :initializer
    end
  end
end
