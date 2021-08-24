module Kuby::KubeDB::DSL::Catalog::V1alpha1
  class MySQLVersionDatabase < ::KubeDSL::DSLObject
    value_field :image

    validates :image, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:image] = image
      end
    end

    def kind_sym
      :my_sql_version_database
    end
  end
end
