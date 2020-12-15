# typed: strict
# frozen_string_literal: true

require_relative 'lib/rails_starter/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails_starter'
  spec.version       = RailsStarter::VERSION
  spec.authors       = ['Tobias Bales']
  spec.email         = ['tobias.bales@gmail.com']

  spec.summary       = 'A simple tool to bootstrap rails applications'
  spec.homepage      = 'https://github.com/TobiasBales/rails_starter'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/TobiasBales/rails_starter'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 6.0'
  spec.add_runtime_dependency 'sorbet-runtime', '~> 0.5.5866'
  spec.add_runtime_dependency 'tty-prompt', '>= 0.22', '< 0.24'
end
