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

    sig { params(path: String).void }
    def initialize(path)
      super(path)

      require_gem('rubocop')
      require_gem('rubocop-performance')
      require_gem('rubocop-rails')
      require_gem('rubocop-minitest')
      require_file('.rubocop.yml')
    end
  end
end
