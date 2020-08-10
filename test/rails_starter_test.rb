# typed: strict
# frozen_string_literal: true

require 'test_helper'

class RailsStarterTest < Minitest::Test
  extend T::Sig

  sig { void }
  def test_that_it_has_a_version_number
    refute_nil ::RailsStarter::VERSION
  end
end
