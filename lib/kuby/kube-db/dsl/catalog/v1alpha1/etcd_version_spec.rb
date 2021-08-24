module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class EtcdVersionSpec < ::KubeDSL::DSLObject
    value_field :deprecated
    object_field(:exporter) { Kuby::KubeDB::DSL::Catalog::V1alpha1::EtcdVersionExporter.new }
    object_field(:db) { Kuby::KubeDB::DSL::Catalog::V1alpha1::EtcdVersionDatabase.new }
    value_field :version
    object_field(:tools) { Kuby::KubeDB::DSL::Catalog::V1alpha1::EtcdVersionTools.new }

    validates :deprecated, field: { format: :boolean }, presence: true
    validates :exporter, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::EtcdVersionExporter }
    validates :db, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::EtcdVersionDatabase }
    validates :version, field: { format: :string }, presence: false
    validates :tools, object: { kind_of: Kuby::KubeDB::DSL::Catalog::V1alpha1::EtcdVersionTools }

    def serialize
      {}.tap do |result|
        result[:deprecated] = deprecated
        result[:exporter] = exporter.serialize
        result[:db] = db.serialize
        result[:version] = version
        result[:tools] = tools.serialize
      end
    end

    def kind_sym
      :etcd_version_spec
    end
  end
end
