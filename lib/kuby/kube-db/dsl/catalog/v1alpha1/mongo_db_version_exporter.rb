module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class MongoDBVersionExporter < ::KubeDSL::DSLObject
    value_field :image

    validates :image, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:image] = image
      end
    end

    def kind_sym
      :mongo_db_version_exporter
    end
  end
end
