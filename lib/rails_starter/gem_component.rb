# typed: strict
# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object'

module RailsStarter
  module GemComponent
    extend T::Sig

    include Kernel

    sig { params(gem: String).void }
    def require_gem(gem)
      gems << gem
      ensure_gems_registered
    end

    private

    sig { params(gem: String, path: String).returns(T::Boolean) }
    def gem_installed?(gem, path)
      file_contains?(File.join(path, 'Gemfile'), gem)
    end

    sig { params(gem: String, path: String).void }
    def install_gem(gem, path)
      append_to_file(File.join(path, 'Gemfile'), "gem '#{gem}'\n")
    end

    sig { void }
    def bundle_install
      Bundler.with_unbundled_env { `bundle install` }
    end

    sig { returns(T::Array[String]) }
    def gems
      @gems = T.let(@gems, T.nilable(T::Array[String]))
      @gems ||= []
    end

    sig { void }
    # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    def ensure_gems_registered
      raise 'Must include RailsStarter::Component first' unless is_a?(RailsStarter::Component)

      @gems_registered = T.let(@gems_registered, T.nilable(T::Boolean))
      @gems_registered ||= false

      return if @gems_registered

      register_met_hook do |path|
        gems.reduce(true) do |met, gem|
          met && gem_installed?(gem, path)
        end
      end

      register_meet_hook do |path|
        gems.each do |gem|
          install_gem(gem, path) unless gem_installed?(gem, path)
        end
        bundle_install
      end

      @gems_registered = true
    end
    # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

    sig { params(filename: String, string: String).returns(T::Boolean) }
    def file_contains?(filename, string)
      File.foreach(filename).detect { |line| line.include?(string) }.present?
    end

    sig { params(filename: String, string: String).void }
    def append_to_file(filename, string)
      File.open(filename, 'a') do |f|
        f.write(string)
      end
    end
  end
end
