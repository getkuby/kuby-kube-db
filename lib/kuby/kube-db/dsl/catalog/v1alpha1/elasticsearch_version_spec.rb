module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class ElasticsearchVersionSpec < ::KubeDSL::DSLObject
    object_field(:exporter) { Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionExporter.new }
    object_field(:pod_security_policies) { Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionPodSecurityPolicy.new }
    object_field(:init_container) { Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionInitContainer.new }
    value_field :deprecated
    object_field(:db) { Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionDatabase.new }
    value_field :version
    object_field(:tools) { Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionTools.new }

    validates :exporter, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionExporter }
    validates :pod_security_policies, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionPodSecurityPolicy }
    validates :init_container, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionInitContainer }
    validates :deprecated, field: { format: :boolean }, presence: true
    validates :db, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionDatabase }
    validates :version, field: { format: :string }, presence: false
    validates :tools, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::ElasticsearchVersionTools }

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
      :elasticsearch_version_spec
    end
  end
end
