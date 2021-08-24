module Kuby::KubeDB::DSL::Appcatalog::V1alpha1
  class AppReference < ::KubeDSL::DSLObject
    value_field :namespace
    value_field :name
    value_field :parameters

    validates :namespace, field: { format: :string }, presence: false
    validates :name, field: { format: :string }, presence: false
    validates :parameters, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:namespace] = namespace
        result[:name] = name
        result[:parameters] = parameters
      end
    end

    def kind_sym
      :app_reference
    end
  end
end
