module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class RoleReference < ::KubeDSL::DSLObject
    value_field :kind
    value_field :namespace
    value_field :name

    validates :kind, field: { format: :string }, presence: false
    validates :namespace, field: { format: :string }, presence: false
    validates :name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:kind] = kind
        result[:namespace] = namespace
        result[:name] = name
      end
    end

    def kind_sym
      :role_reference
    end
  end
end
