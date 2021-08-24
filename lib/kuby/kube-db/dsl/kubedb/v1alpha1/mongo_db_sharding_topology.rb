module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class MongoDBShardingTopology < ::KubeDSL::DSLObject
    object_field(:shard) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBShardNode.new }
    object_field(:mongos) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBMongosNode.new }
    object_field(:config_server) { Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBConfigNode.new }

    validates :shard, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBShardNode }
    validates :mongos, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBMongosNode }
    validates :config_server, object: { kind_of: Kuby::KubeDB::DSL::Kubedb::V1alpha1::MongoDBConfigNode }

    def serialize
      {}.tap do |result|
        result[:shard] = shard.serialize
        result[:mongos] = mongos.serialize
        result[:configServer] = config_server.serialize
      end
    end

    def kind_sym
      :mongo_db_sharding_topology
    end
  end
end
