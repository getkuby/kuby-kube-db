module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class InitSpec < ::KubeDSL::DSLObject
    object_field(:postgres_wal) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::PostgresWALSourceSpec.new }
    object_field(:snapshot_source) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::SnapshotSourceSpec.new }
    object_field(:script_source) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::ScriptSourceSpec.new }

    validates :postgres_wal, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::PostgresWALSourceSpec }
    validates :snapshot_source, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::SnapshotSourceSpec }
    validates :script_source, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::ScriptSourceSpec }

    def serialize
      {}.tap do |result|
        result[:postgresWAL] = postgres_wal.serialize
        result[:snapshotSource] = snapshot_source.serialize
        result[:scriptSource] = script_source.serialize
      end
    end

    def kind_sym
      :init_spec
    end
  end
end
