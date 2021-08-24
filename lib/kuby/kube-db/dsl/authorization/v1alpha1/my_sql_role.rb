module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class MySQLRole < ::KubeDSL::DSLObject
    object_field(:status) { Kuby::KubeDB::DSL::Authorization::V1alpha1::MySQLRoleStatus.new }
    object_field(:spec) { Kuby::KubeDB::DSL::Authorization::V1alpha1::MySQLRoleSpec.new }
    value_field :api_version
    object_field(:metadata) { KubeDSL::DSL::Meta::V1::ObjectMeta.new }

    validates :status, object: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::MySQLRoleStatus }
    validates :spec, object: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::MySQLRoleSpec }
    validates :api_version, field: { format: :string }, presence: false
    validates :metadata, object: { kind_of: KubeDSL::DSL::Meta::V1::ObjectMeta }

    def serialize
      {}.tap do |result|
        result[:status] = status.serialize
        result[:kind] = "MySQLRole"
        result[:spec] = spec.serialize
        result[:apiVersion] = api_version
        result[:metadata] = metadata.serialize
      end
    end

    def kind_sym
      :my_sql_role
    end
  end
end
