# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class Brakeman
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
      gem_installed?('brakeman', @path)
    end

    def meet
      install_gem('brakeman', @path) unless gem_installed?('brakeman', @path)
      bundle_install
    end
  end
end
