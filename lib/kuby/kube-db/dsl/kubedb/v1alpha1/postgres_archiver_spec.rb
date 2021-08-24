module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class PostgresArchiverSpec < ::KubeDSL::DSLObject
    object_field(:storage) { Kuby::KubeDB::DSL::API::V1::Backend.new }

    validates :storage, object: { kind_of: Kuby::KubeDB::DSL::API::V1::Backend }

    def serialize
      {}.tap do |result|
        result[:storage] = storage.serialize
      end
    end

    def kind_sym
      :postgres_archiver_spec
    end
  end
end
