# typed: strict
# frozen_string_literal: true

module RailsStarter
  module FileComponent
    extend T::Sig

    include Kernel

    sig { params(file: String).void }
    def require_file(file)
      files << file
      ensure_files_registered
    end

    private

    sig { returns(T::Array[String]) }
    def files
      @files = T.let(@files, T.nilable(T::Array[String]))
      @files ||= []
    end

    sig { void }
    # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    def ensure_files_registered
      raise 'Must include RailsStarter::Component first' unless is_a?(RailsStarter::Component)

      @files_registered = T.let(@files_registered, T.nilable(T::Boolean))
      @files_registered ||= false

      return if @files_registered

      register_met_hook do |path|
        files.reduce(true) do |met, file|
          met && file_exists?(file, path)
        end
      end

      register_meet_hook do |path|
        files.each do |file|
          copy_file(file, path) unless file_exists?(file, path)
        end
      end

      @files_registered = true
    end
    # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity

    sig { params(filename: String, path: String).void }
    def copy_file(filename, path)
      FileUtils.copy(source_file_path(filename), File.join(path, filename))
    end

    sig { params(filename: String, path: String).returns(T::Boolean) }
    def file_exists?(filename, path)
      File.exist?(File.join(path, filename))
    end

    sig { params(filename: String).returns(String) }
    def source_file_path(filename)
      File.join(File.dirname(__FILE__), '..', '..', 'static', filename)
    end
  end
end
