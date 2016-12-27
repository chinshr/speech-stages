require 'test_helper'

class Speech::Stages::VersionTest < Test::Unit::TestCase

  def test_current_version
    assert_equal "0.0.4", Speech::Stages::VERSION
  end

end
