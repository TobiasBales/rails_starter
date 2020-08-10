# typed: strict
# frozen_string_literal: true

require 'rails_starter/component'

module RailsStarter
  class Rubocop
    extend T::Sig

    include Component

    sig { params(path: String).void }
    def initialize(path)
      @path = path
    end

    sig { override.returns(T::Boolean) }
    def met?
      File.exist?(File.join(@path, '.rubocop.yml'))
    end

    sig { override.returns(T::Boolean) }
    def meet
      FileUtils.cp(source_file_path('.rubocop.yml'), File.join(@path, '.rubocop.yml'))
      true
    end

    private

    def source_file_path(filename)
      File.join(Dir.getwd, 'static', filename)
    end
  end
end
