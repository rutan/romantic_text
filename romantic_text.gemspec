# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'romantic_text/version'

Gem::Specification.new do |spec|
  spec.name          = 'romantic_text'
  spec.version       = RomanticText::VERSION
  spec.authors       = ['ru_shalm']
  spec.email         = ['ru_shalm@hazimu.com']

  spec.summary       = 'A romantic DSL for writing HTML.'
  spec.homepage      = 'https://github.com/rutan/romantic_text'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '0.72.0'
  spec.add_development_dependency 'test-unit', '~> 3.3'
  spec.add_development_dependency 'test-unit-rr', '~> 1.0'
end
