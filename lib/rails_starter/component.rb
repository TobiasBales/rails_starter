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

    sig { abstract.returns(T::Boolean) }
    def met?; end

    sig { abstract.void }
    def meet; end
  end
end
