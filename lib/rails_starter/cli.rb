# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'tty-prompt'

module RailsStarter
  class CLI
    extend T::Sig

    sig { params(prompt: TTY::Prompt).void }
    def initialize(prompt = TTY::Prompt.new)
      @prompt = prompt
    end

    sig { void }
    def self.start
      puts 'This is rails_starter, sadly it does not do anything right now'
    end
  end
end
