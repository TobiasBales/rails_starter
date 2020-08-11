# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class Rubocop
    extend T::Sig

    include Component
    include FileComponent
    include GemComponent

    sig { params(path: String).void }
    def initialize(path)
      @path = path
    end

    sig { override.returns(T::Boolean) }
    def met?
      gem_installed?('rubocop') &&
        gem_installed?('rubocop-performance') &&
        gem_installed?('rubocop-rails') &&
        gem_installed?('rubocop-minitest') &&
        file_exists?('.rubocop.yml', @path)
    end

    sig { override.void }
    def meet
      install_gem('rubocop') unless gem_installed?('rubocop')
      install_gem('rubocop-performance') unless gem_installed?('rubocop-performance')
      install_gem('rubocop-rails') unless gem_installed?('rubocop-rails')
      install_gem('rubocop-minitest') unless gem_installed?('rubocop-minitest')
      copy_file('.rubocop.yml', @path) unless file_exists?('.rubocop.yml', @path)
      bundle_install
    end
  end
end
