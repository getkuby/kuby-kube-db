module Kuby::KubeDB::DSL::Kubedb::V1alpha1
  class SnapshotSpec < ::KubeDSL::DSLObject
    value_field :storage_secret_name
    object_field(:b2) { Kuby::KubeDB::DSL::API::V1::B2Spec.new }
    object_field(:pod_template) { Kuby::KubeDB::DSL::API::V1::PodTemplateSpec.new }
    object_field(:swift) { Kuby::KubeDB::DSL::API::V1::SwiftSpec.new }
    object_field(:pod_volume_claim_spec) { KubeDSL::DSL::V1::PersistentVolumeClaimSpec.new }
    object_field(:rest) { Kuby::KubeDB::DSL::API::V1::RestServerSpec.new }
    object_field(:s3) { Kuby::KubeDB::DSL::API::V1::S3Spec.new }
    object_field(:gcs) { Kuby::KubeDB::DSL::API::V1::GCSSpec.new }
    value_field :storage_type
    value_field :database_name
    object_field(:azure) { Kuby::KubeDB::DSL::API::V1::AzureSpec.new }
    object_field(:local) { Kuby::KubeDB::DSL::API::V1::LocalSpec.new }

    validates :storage_secret_name, field: { format: :string }, presence: false
    validates :b2, object: { kind_of: Kuby::KubeDB::DSL::API::V1::B2Spec }
    validates :pod_template, object: { kind_of: Kuby::KubeDB::DSL::API::V1::PodTemplateSpec }
    validates :swift, object: { kind_of: Kuby::KubeDB::DSL::API::V1::SwiftSpec }
    validates :pod_volume_claim_spec, object: { kind_of: KubeDSL::DSL::V1::PersistentVolumeClaimSpec }
    validates :rest, object: { kind_of: Kuby::KubeDB::DSL::API::V1::RestServerSpec }
    validates :s3, object: { kind_of: Kuby::KubeDB::DSL::API::V1::S3Spec }
    validates :gcs, object: { kind_of: Kuby::KubeDB::DSL::API::V1::GCSSpec }
    validates :storage_type, field: { format: :string }, presence: false
    validates :database_name, field: { format: :string }, presence: false
    validates :azure, object: { kind_of: Kuby::KubeDB::DSL::API::V1::AzureSpec }
    validates :local, object: { kind_of: Kuby::KubeDB::DSL::API::V1::LocalSpec }

    def serialize
      {}.tap do |result|
        result[:storageSecretName] = storage_secret_name
        result[:b2] = b2.serialize
        result[:podTemplate] = pod_template.serialize
        result[:swift] = swift.serialize
        result[:podVolumeClaimSpec] = pod_volume_claim_spec.serialize
        result[:rest] = rest.serialize
        result[:s3] = s3.serialize
        result[:gcs] = gcs.serialize
        result[:storageType] = storage_type
        result[:databaseName] = database_name
        result[:azure] = azure.serialize
        result[:local] = local.serialize
      end
    end

    def kind_sym
      :snapshot_spec
    end
  end
end
