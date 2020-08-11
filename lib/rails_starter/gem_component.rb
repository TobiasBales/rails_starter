# typed: strict
# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object'

module RailsStarter
  module GemComponent
    extend T::Sig

    sig { params(gem: String).returns(T::Boolean) }
    def gem_installed?(gem)
      file_contains?(File.join(Dir.getwd, 'Gemfile'), gem)
    end

    sig { params(gem: String).void }
    def install_gem(gem)
      append_to_file('Gemfile', "gem '#{gem}'\n")
    end

    sig { void }
    def bundle_install
      Bundler.with_unbundled_env { `bundle install` }
    end

    private

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
