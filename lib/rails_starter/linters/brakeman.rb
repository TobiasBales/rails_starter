# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class Brakeman < Component
    extend T::Sig

    include GemComponent

    sig { params(path: String).void }
    def initialize(path)
      super(path)

      require_gem 'brakeman'
    end
  end
end
