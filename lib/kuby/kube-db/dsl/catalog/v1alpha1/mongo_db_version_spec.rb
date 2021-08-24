module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class MongoDBVersionSpec < ::KubeDSL::DSLObject
    object_field(:exporter) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionExporter.new }
    object_field(:pod_security_policies) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionPodSecurityPolicy.new }
    object_field(:init_container) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionInitContainer.new }
    value_field :deprecated
    object_field(:db) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionDatabase.new }
    value_field :version
    object_field(:tools) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionTools.new }

    validates :exporter, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionExporter }
    validates :pod_security_policies, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionPodSecurityPolicy }
    validates :init_container, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionInitContainer }
    validates :deprecated, field: { format: :boolean }, presence: true
    validates :db, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionDatabase }
    validates :version, field: { format: :string }, presence: false
    validates :tools, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MongoDBVersionTools }

    def serialize
      {}.tap do |result|
        result[:exporter] = exporter.serialize
        result[:podSecurityPolicies] = pod_security_policies.serialize
        result[:initContainer] = init_container.serialize
        result[:deprecated] = deprecated
        result[:db] = db.serialize
        result[:version] = version
        result[:tools] = tools.serialize
      end
    end

    def kind_sym
      :mongo_db_version_spec
    end
  end
end
