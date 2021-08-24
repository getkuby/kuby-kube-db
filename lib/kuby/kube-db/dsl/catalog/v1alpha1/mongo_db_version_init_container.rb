module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class MongoDBVersionInitContainer < ::KubeDSL::DSLObject
    value_field :image

    validates :image, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:image] = image
      end
    end

    def kind_sym
      :mongo_db_version_init_container
    end
  end
end
