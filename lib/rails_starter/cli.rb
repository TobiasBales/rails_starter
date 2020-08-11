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
    # rubocop:disable Metrics/MethodLength
    def start
      linter_options = RailsStarter::Linters.for_path(Dir.getwd)

      if linter_options.values.any? { |l| !l.met? }
        linters = @prompt.multi_select('Which linters do you want?') do |menu|
          RailsStarter::Linters.for_path(Dir.getwd).each do |linter, component|
            menu.choice linter, component, disabled: component.met? ? '(already installed)' : nil
          end
        end

        linters.each(&:meet)
      else
        puts 'All available linters are already installed'
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
