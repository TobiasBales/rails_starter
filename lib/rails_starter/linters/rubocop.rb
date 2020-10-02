# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/binary_component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class Rubocop < Component
    extend T::Sig

    include FileComponent
    include GemComponent
    include BinaryComponent

    sig { params(path: String).void }
    def initialize(path)
      super(path)

      require_gem('rubocop')
      require_gem('rubocop-performance')
      require_gem('rubocop-rails')
      require_gem('rubocop-minitest')

      require_file('.rubocop.yml')

      provides_binary('rubocop', 'bundle exec rubocop --config .rubocop.yml')
      provides_binary('rubocop_fix', 'bundle exec rubocop --auto-correct-all --config .rubocop.yml')
    end
  end
end
