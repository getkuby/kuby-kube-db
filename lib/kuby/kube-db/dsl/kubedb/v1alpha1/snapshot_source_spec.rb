module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class SnapshotSourceSpec < ::KubeDSL::DSLObject
    value_field :args
    value_field :namespace
    value_field :name

    validates :args, field: { format: :string }, presence: false
    validates :namespace, field: { format: :string }, presence: false
    validates :name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:args] = args
        result[:namespace] = namespace
        result[:name] = name
      end
    end

    def kind_sym
      :snapshot_source_spec
    end
  end
end
