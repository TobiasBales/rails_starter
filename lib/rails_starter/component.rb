# typed: strict
# frozen_string_literal: true

module RailsStarter
  class Component
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { params(path: String).void }
    def initialize(path)
      @path = path
    end

    sig { params(blk: T.proc.params(path: String).returns(T::Boolean)).void }
    def self.register_met_hook(&blk)
      met_hooks << blk
    end

    sig { params(blk: T.proc.params(path: String).void).void }
    def self.register_meet_hook(&blk)
      meet_hooks << blk
    end

    sig { overridable.returns(T::Boolean) }
    def met?
      self.class.met_hooks.reduce(true) do |met, blk|
        met && blk.yield(@path)
      end
    end

    sig { overridable.void }
    def meet
      self.class.meet_hooks.each do |blk|
        blk.yield(@path)
      end
    end

    class << self
      private

      sig { returns(T::Array[T.proc.params(path: String).returns(T::Boolean)]) }
      def met_hooks
        @met_hooks = T.let(@met_hooks, T.nilable(T::Array[T.proc.params(path: String).returns(T::Boolean)]))
        @met_hooks ||= []
      end

      sig { returns(T::Array[T.proc.params(path: String).void]) }
      def meet_hooks
        @meet_hooks = T.let(@meet_hooks, T.nilable(T::Array[T.proc.params(path: String).void]))
        @meet_hooks ||= []
      end
    end
  end
end
