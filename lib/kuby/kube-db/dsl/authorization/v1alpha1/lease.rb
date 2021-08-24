module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class Lease < ::KubeDSL::DSLObject
    value_field :duration
    value_field :id
    value_field :renewable

    validates :duration, field: { format: :string }, presence: false
    validates :id, field: { format: :string }, presence: false
    validates :renewable, field: { format: :boolean }, presence: true

    def serialize
      {}.tap do |result|
        result[:duration] = duration
        result[:id] = id
        result[:renewable] = renewable
      end
    end

    def kind_sym
      :lease
    end
  end
end
