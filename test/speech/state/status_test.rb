require 'test_helper'

class Speech::State::StatusTest < Test::Unit::TestCase

  def test_status_unprocessed
    assert_equal 0, Speech::State::STATUS_UNPROCESSED
  end

  def test_status_processing
    assert_equal 1, Speech::State::STATUS_PROCESSING
  end

  def test_status_processed
    assert_equal 3, Speech::State::STATUS_PROCESSED
  end

  def test_status_processing_error
    assert_equal -1, Speech::State::STATUS_PROCESSING_ERROR
  end

end
