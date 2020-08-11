# typed: strict
# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object'

module RailsStarter
  module GemComponent
    extend T::Sig

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
