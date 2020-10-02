# typed: strict
# frozen_string_literal: true

module RailsStarter
  module BinaryComponent
    extend T::Sig

    include Kernel

    sig { params(name: String, script: String).void }
    def provides_binary(name, script)
      @binaries ||= {}
      @binaries[name] = script

      ensure_binaries_registered
    end

    private

    sig { returns(T::Hash[String, String]) }
    def binaries
      @binaries = T.let(@binaries, T.nilable(T::Hash[String, String]))
      @binaries ||= {}
    end

    sig { void }
    # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    def ensure_binaries_registered
      raise 'Must include RailsStarter::Component first' unless is_a?(RailsStarter::Component)

      @binaries_registered = T.let(@binaries_registered, T.nilable(T::Boolean))
      @binaries_registered ||= false

      return if @binaries_registered

      register_met_hook do |path|
        binaries.reduce(true) do |met, (name, _)|
          met && binary_exists?(path, name)
        end
      end

      register_meet_hook do |path|
        binaries.each do |name, script|
          create_binary(path, name, script) unless binary_exists?(path, name)
        end
      end

      @binaries_registered = true
    end
    # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

    sig { params(path: String, name: String).returns(T::Boolean) }
    def binary_exists?(path, name)
      File.exist?(File.join(path, 'bin', name))
    end

    sig { params(path: String, name: String, script: String).void }
    def create_binary(path, name, script)
      bin_directory = File.join(path, 'bin')
      FileUtils.mkdir_p(bin_directory) unless File.directory?(bin_directory)

      bin_file = File.join(bin_directory, name)

      File.write(bin_file, <<~SH
        #/usr/bin/env bash
        set -euo pipefail

        #{script}
      SH
      )

      FileUtils.chmod('+x', bin_file)
    end
  end
end
