module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class MemcachedVersionSpec < ::KubeDSL::DSLObject
    value_field :deprecated
    object_field(:exporter) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MemcachedVersionExporter.new }
    object_field(:db) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MemcachedVersionDatabase.new }
    value_field :version
    object_field(:pod_security_policies) { Kuby::KubeDB::DSL::Catalog::V1alpha1::MemcachedVersionPodSecurityPolicy.new }

    validates :deprecated, field: { format: :boolean }, presence: true
    validates :exporter, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MemcachedVersionExporter }
    validates :db, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MemcachedVersionDatabase }
    validates :version, field: { format: :string }, presence: false
    validates :pod_security_policies, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::MemcachedVersionPodSecurityPolicy }

    def serialize
      {}.tap do |result|
        result[:deprecated] = deprecated
        result[:exporter] = exporter.serialize
        result[:db] = db.serialize
        result[:version] = version
        result[:podSecurityPolicies] = pod_security_policies.serialize
      end
    end

    def kind_sym
      :memcached_version_spec
    end
  end
end
