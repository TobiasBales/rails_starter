# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'rails_starter/linters'
require 'tty-prompt'

module RailsStarter
  class CLI
    extend T::Sig

    sig { params(prompt: TTY::Prompt).void }
    def initialize(prompt = TTY::Prompt.new)
      @prompt = prompt
    end

    sig { void }
    def start
      linters = @prompt.multi_select('Which linters do you want?') do |menu|
        RailsStarter::Linters.for_path(Dir.getwd).each do |linter, component|
          menu.choice linter, component, disabled: component.met? ? '(already installed)' : nil
        end
      end

      linters.each(&:meet)
    end
  end
end
