$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'kuby/kube-db/version'

Gem::Specification.new do |s|
  s.name     = 'kuby-kube-db'
  s.version  = ::Kuby::KubeDB::VERSION
  s.authors  = ['Cameron Dutro']
  s.email    = ['camertron@gmail.com']
  s.homepage = 'http://github.com/getkuby/kuby-kube-db'

  s.description = s.summary = 'KubeDB plugin for Kuby.'

  s.platform = Gem::Platform::RUBY

  s.add_dependency 'helm-cli', '~> 0.3'
  s.add_dependency 'helm-rb', '~> 0.2'
  s.add_dependency 'kube-dsl', '>= 0.6.1', '< 1.0'

  s.require_path = 'lib'
  s.files = Dir['{lib,spec}/**/*', 'Gemfile', 'LICENSE', 'CHANGELOG.md', 'README.md', 'Rakefile', 'kuby-kube-db.gemspec']
end
