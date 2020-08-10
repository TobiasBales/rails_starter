# typed: strict
# frozen_string_literal: true

require 'thor'

module RailsStarter
  class CLI
    extend T::Sig

    sig { void }
    def self.start
      puts 'This is rails_starter, sadly it does not do anything right now'
    end
  end
end
