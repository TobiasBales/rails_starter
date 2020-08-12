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
      @met_hooks = T.let([], T::Array[T.proc.params(path: String).returns(T::Boolean)])
      @meet_hooks = T.let([], T::Array[T.proc.params(path: String).void])
    end

    sig { params(blk: T.proc.params(path: String).returns(T::Boolean)).void }
    def register_met_hook(&blk)
      @met_hooks << blk
    end

    sig { params(blk: T.proc.params(path: String).void).void }
    def register_meet_hook(&blk)
      @meet_hooks << blk
    end

    sig { overridable.returns(T::Boolean) }
    def met?
      @met_hooks.reduce(true) do |met, blk|
        met && blk.yield(@path)
      end
    end

    sig { overridable.void }
    def meet
      @meet_hooks.each do |blk|
        blk.yield(@path)
      end
    end
  end
end
