# typed: strict
# frozen_string_literal: true

module RailsStarter
  module Component
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(T::Boolean) }
    def met?; end

    sig { abstract.returns(T::Boolean) }
    def meet; end
  end
end
