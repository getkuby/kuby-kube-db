module Kuby::KubeDB::DSL::API::V1
  class RestServerSpec < ::KubeDSL::DSLObject
    value_field :url

    validates :url, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:url] = url
      end
    end

    def kind_sym
      :rest_server_spec
    end
  end
end
