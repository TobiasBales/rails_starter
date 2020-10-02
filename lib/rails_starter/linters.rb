# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'
require 'rails_starter/linters/brakeman'
require 'rails_starter/linters/rails_best_practices'
require 'rails_starter/linters/rubocop'

module RailsStarter
  class Linters
    extend T::Sig

    sig { params(path: String).returns(T::Hash[Symbol, RailsStarter::Component]) }
    def self.for_path(path)
      {
        brakeman: RailsStarter::Brakeman.new(path),
        rails_best_practices: RailsStarter::RailsBestPractices.new(path),
        rubocop: RailsStarter::Rubocop.new(path)
      }
    end
  end
end
