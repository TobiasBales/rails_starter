# typed: strict
# frozen_string_literal: true

require 'test_helper'
require 'rails_starter/linters/rubocop'

class RubocopTest < Minitest::Test
  extend T::Sig

  sig { void }
  def test_that_met_works_when_not_met
    path = fixture_path('unmet')

    subject = RailsStarter::Rubocop.new(path)

    refute subject.met?
  end

  sig { void }
  def test_that_met_works_when_met
    path = fixture_path('met')

    subject = RailsStarter::Rubocop.new(path)

    assert subject.met?
  end

  sig { void }
  def test_that_meet_results_in_met
    FileUtils.mkdir_p tmp_path
    Dir.mktmpdir('meet_results_in_met', tmp_path) do |d|
      `touch #{File.join(d, 'Gemfile')}`
      subject = RailsStarter::Rubocop.new(d)

      refute subject.met?, 'Should not be met on new directory'

      subject.meet

      assert subject.met?, 'After meet was called it should be met'
    end
  end

  private

  sig { returns(String) }
  def tmp_path
    File.join(Dir.getwd, 'test', 'tmp', 'linters', 'rubocop')
  end

  sig { params(fixture: String).returns(String) }
  def fixture_path(fixture)
    File.join(Dir.getwd, 'test', 'fixtures', 'linters', 'rubocop', fixture)
  end
end
