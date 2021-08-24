module Kuby::KubeDB::DSL::Authorization::V1alpha1
  class DatabaseAccessRequestStatus < ::KubeDSL::DSLObject
    object_field(:secret) { KubeDSL::DSL::V1::LocalObjectReference.new }
    array_field(:condition) { Kuby::KubeDB::DSL::Authorization::V1alpha1::DatabaseAccessRequestCondition.new }
    object_field(:lease) { Kuby::KubeDB::DSL::Authorization::V1alpha1::Lease.new }

    validates :secret, object: { kind_of: KubeDSL::DSL::V1::LocalObjectReference }
    validates :conditions, array: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::DatabaseAccessRequestCondition }, presence: false
    validates :lease, object: { kind_of: Kuby::KubeDB::DSL::Authorization::V1alpha1::Lease }

    def serialize
      {}.tap do |result|
        result[:secret] = secret.serialize
        result[:conditions] = conditions.map(&:serialize)
        result[:lease] = lease.serialize
      end
    end

    def kind_sym
      :database_access_request_status
    end
  end
end
