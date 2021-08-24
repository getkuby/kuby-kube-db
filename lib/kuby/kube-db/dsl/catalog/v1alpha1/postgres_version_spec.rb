module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class PostgresVersionSpec < ::KubeDSL::DSLObject
    object_field(:exporter) { Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionExporter.new }
    object_field(:pod_security_policies) { Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionPodSecurityPolicy.new }
    value_field :deprecated
    object_field(:db) { Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionDatabase.new }
    value_field :version
    object_field(:tools) { Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionTools.new }

    validates :exporter, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionExporter }
    validates :pod_security_policies, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionPodSecurityPolicy }
    validates :deprecated, field: { format: :boolean }, presence: true
    validates :db, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionDatabase }
    validates :version, field: { format: :string }, presence: false
    validates :tools, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::PostgresVersionTools }

    def serialize
      {}.tap do |result|
        result[:exporter] = exporter.serialize
        result[:podSecurityPolicies] = pod_security_policies.serialize
        result[:deprecated] = deprecated
        result[:db] = db.serialize
        result[:version] = version
        result[:tools] = tools.serialize
      end
    end

    def kind_sym
      :postgres_version_spec
    end
  end
end
