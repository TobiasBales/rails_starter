# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/file_component'

module RailsStarter
  class Rubocop
    extend T::Sig

    include Component
    include FileComponent

    sig { params(path: String).void }
    def initialize(path)
      @path = path
    end

    sig { override.returns(T::Boolean) }
    def met?
      file_exists?('.rubocop.yml', @path)
    end

    sig { override.returns(T::Boolean) }
    def meet
      copy_file('.rubocop.yml', @path)
      true
    end
  end
end
