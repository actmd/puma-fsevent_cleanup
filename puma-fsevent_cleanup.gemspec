# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puma/fsevent_cleanup/version'

Gem::Specification.new do |spec|
  spec.name          = 'puma-fsevent_cleanup'
  spec.version       = Puma::FseventCleanup::VERSION
  spec.authors       = ['Joon Lee']
  spec.email         = ['joon@act.md']

  spec.summary       = 'Puma plugin to fix running too many fsevent_watch processes'
  spec.description   = 'Puma plugin to fix running too many fsevent_watch processes'
  spec.homepage      = 'https://github.com/actmd/puma-fsevent_cleanup'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'puma', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
