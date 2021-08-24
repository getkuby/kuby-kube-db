require 'bundler'
require 'rspec/core/rake_task'
require 'rubygems/package_task'

require 'kuby/kube-db'
require 'pry-byebug'

Bundler::GemHelper.install_tasks

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

task :generate do
  require 'dry/inflector'
  require 'fileutils'

  # delete anything that should be re-generated
  FileUtils.rm_rf('./lib/kuby/kube-db/entrypoint.rb')
  FileUtils.rm_rf('./lib/kuby/kube-db/dsl.rb')
  FileUtils.rm_rf('./lib/kuby/kube-db/dsl')
  FileUtils.mkdir_p('./lib/kuby/kube-db/dsl')
  FileUtils.mkdir_p('./vendor')

  schema_url = "https://github.com/kubedb/apimachinery/blob/#{Kuby::KubeDB::KUBEDB_VERSION}/api/openapi-spec/swagger.json?raw=true"
  local_json_schema_path = 'vendor/json_schema'

  unless File.exist?(local_json_schema_path)
    FileUtils.mkdir_p(local_json_schema_path)
    system('docker pull garethr/openapi2jsonschema')

    system(<<~END)
      docker run --rm \
        -v #{File.expand_path(local_json_schema_path)}:/usr/local/json_schema \
        garethr/openapi2jsonschema \
        --kubernetes --output /usr/local/json_schema #{schema_url}
    END
  end

  generator = KubeDSL::Generator.new(
    schema_dir: local_json_schema_path,
    output_dir: File.join('lib'),
    autoload_prefix: File.join('kuby', 'kube-db', 'dsl'),
    dsl_namespace: ['Kuby', 'KubeDB', 'DSL'],
    entrypoint_namespace: ['Kuby', 'KubeDB'],
    inflector: Dry::Inflector.new do |inflections|
      inflections.acronym('DSL')
      inflections.acronym('DB')
    end
  )

  # WTF even is xyz.kmodules??
  generator.builder.register_resolver('io.k8s', 'xyz.kmodules') do |ref_str, builder|
    external_ref = ::KubeDSL::ExternalRef.new(
      ref_str,
      ['KubeDSL', 'DSL'],
      builder.inflector,
      builder.schema_dir,
      builder.autoload_prefix
    )

    ns = external_ref.ruby_namespace + [external_ref.kind]
    exists = ns.inject(Object) { |mod, n| mod.const_get(n, false) } rescue false
    exists ? external_ref : builder.parse_ref(ref_str)
  end

  generator.generate_resource_files
  generator.generate_autoload_files
  generator.generate_entrypoint_file do |resource, ns|
    ns =~ /Kuby::KubeDB::DSL::Kubedb::V1alpha1/
  end
end
