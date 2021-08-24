module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MySQLGroupSpec < ::KubeDSL::DSLObject
    value_field :base_server_id
    value_field :mode
    value_field :name

    validates :base_server_id, field: { format: :integer }, presence: true
    validates :mode, field: { format: :string }, presence: false
    validates :name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:baseServerID] = base_server_id
        result[:mode] = mode
        result[:name] = name
      end
    end

    def kind_sym
      :my_sql_group_spec
    end
  end
end
