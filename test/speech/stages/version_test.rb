require 'test_helper'

class Speech::Stages::VersionTest < Test::Unit::TestCase

  def test_current_version
    assert_equal "0.0.1", Speech::Stages::VERSION
  end

end