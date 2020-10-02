# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/binary_component'
require 'rails_starter/file_component'
require 'rails_starter/gem_component'

module RailsStarter
  class RailsBestPractices < Component
    extend T::Sig

    include BinaryComponent
    include FileComponent
    include GemComponent

    sig { params(path: String).void }
    def initialize(path)
      super(path)

      require_gem('rails_best_practices')

      require_file('rails_best_practices.yml')

      provides_binary('rails_best_practices', 'bundle exec rails_best_practices --config rails_best_practices.yml')
    end
  end
end
