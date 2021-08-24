module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class ElasticsearchVersionInitContainer < ::KubeDSL::DSLObject
    value_field :image

    validates :image, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:image] = image
      end
    end

    def kind_sym
      :elasticsearch_version_init_container
    end
  end
end
