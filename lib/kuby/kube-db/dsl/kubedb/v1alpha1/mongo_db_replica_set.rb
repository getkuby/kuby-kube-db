module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDBReplicaSet < ::KubeDSL::DSLObject
    object_field(:key_file) { KubeDSL::DSL::V1::SecretVolumeSource.new }
    value_field :name

    validates :key_file, object: { kind_of: KubeDSL::DSL::V1::SecretVolumeSource }
    validates :name, field: { format: :string }, presence: false

    def serialize
      {}.tap do |result|
        result[:keyFile] = key_file.serialize
        result[:name] = name
      end
    end

    def kind_sym
      :mongo_db_replica_set
    end
  end
end
