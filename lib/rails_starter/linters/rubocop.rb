# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class Rubocop < Component
    extend T::Sig

    include FileComponent
    include GemComponent

    sig { override.returns(T::Boolean) }
    def met?
      gem_installed?('rubocop', @path) &&
        gem_installed?('rubocop-performance', @path) &&
        gem_installed?('rubocop-rails', @path) &&
        gem_installed?('rubocop-minitest', @path) &&
        file_exists?('.rubocop.yml', @path)
    end

    sig { override.void }
    def meet
      install_gem('rubocop', @path) unless gem_installed?('rubocop', @path)
      install_gem('rubocop-performance', @path) unless gem_installed?('rubocop-performance', @path)
      install_gem('rubocop-rails', @path) unless gem_installed?('rubocop-rails', @path)
      install_gem('rubocop-minitest', @path) unless gem_installed?('rubocop-minitest', @path)
      copy_file('.rubocop.yml', @path) unless file_exists?('.rubocop.yml', @path)
      bundle_install
    end
  end
end
