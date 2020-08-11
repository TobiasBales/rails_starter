# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class Brakeman < Component
    extend T::Sig

    include FileComponent
    include GemComponent

    sig { override.returns(T::Boolean) }
    def met?
      gem_installed?('brakeman', @path)
    end

    sig { override.void }
    def meet
      install_gem('brakeman', @path) unless gem_installed?('brakeman', @path)
      bundle_install
    end
  end
end
