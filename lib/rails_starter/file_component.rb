# typed: strict
# frozen_string_literal: true

module RailsStarter
  module FileComponent
    extend T::Sig

    sig { params(filename: String, path: String).void }
    def copy_file(filename, path)
      FileUtils.copy(source_file_path(filename), File.join(path, filename))
    end

    sig { params(filename: String, path: String).returns(T::Boolean) }
    def file_exists?(filename, path)
      File.exist?(File.join(path, filename))
    end

    private

    sig { params(filename: String).returns(String) }
    def source_file_path(filename)
      File.join(Dir.getwd, 'static', filename)
    end
  end
end
