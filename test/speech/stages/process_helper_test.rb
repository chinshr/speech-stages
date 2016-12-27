require 'test_helper.rb'

class Speech::Stages::ProcessHelperTest < Test::Unit::TestCase

  class ChunksterWithStatus
    include Speech::Stages::ProcessHelper

    attr_accessor :status
  end

  class ChunksterWithoutStatus
    include Speech::Stages::ProcessHelper
  end

  def setup
    @entity = ChunksterWithStatus.new
  end

  def test_should_get_processed_stages
    assert_equal [], @entity.processed_stages.get
  end

  def test_should_to_a_processed_stages
    assert_equal [], @entity.processed_stages.to_a
  end

  def test_should_set_processed_stages
    @entity.processed_stages = :build
    assert_equal [:build], @entity.processed_stages.to_a
  end

  def test_should_add_processed_stage
    @entity.processed_stages.add(:build)
    assert_equal [:build], @entity.processed_stages.to_a
    assert_equal Speech::Stages::ProcessedStages::PROCESSED_STAGES[:build], @entity.processed_stages.bits
    @entity.processed_stages.add(:build)
    assert_equal Speech::Stages::ProcessedStages::PROCESSED_STAGES[:build], @entity.processed_stages.bits
  end

  def test_should_alias_push_processed_stage
    @entity.processed_stages.push(:build)
    assert_equal [:build], @entity.processed_stages.to_a
  end

  def test_should_not_add_unknown_stage
    @entity.processed_stages << :foobar
    assert_equal [], @entity.processed_stages.to_a
  end

  def test_should_add_operator_processed_stage
    @entity.processed_stages << :build
    assert_equal [:build], @entity.processed_stages.to_a
    @entity.processed_stages << :encode
    assert_equal [:build, :encode], @entity.processed_stages.to_a
    @entity.processed_stages << :convert
    assert_equal [:build, :encode, :convert], @entity.processed_stages.to_a
    @entity.processed_stages << :extract
    assert_equal [:build, :encode, :convert, :extract], @entity.processed_stages.to_a
  end

  def test_should_use_equal_operator
    @entity.processed_stages << :build
    assert_equal true, @entity.processed_stages == [:build]
  end

  def test_should_include
    assert_equal false, @entity.processed_stages.include?(:build)
    @entity.processed_stages << :build
    assert_equal true, @entity.processed_stages.include?(:build)
  end

  def test_should_status
    @entity.processed_stages << :build
    assert_equal Speech::Stages::ProcessedStages::PROCESSED_STAGES[:build], @entity.processed_stages.status
  end

  def test_should_build
    @entity.processed_stages << :build
    assert_equal [:build], @entity.processed_stages.to_a
    assert_equal true, @entity.built?
  end

  def test_should_encode
    @entity.processed_stages << :encode
    assert_equal [:encode], @entity.processed_stages.to_a
    assert_equal true, @entity.encoded?
  end

  def test_should_convert
    @entity.processed_stages << :convert
    assert_equal [:convert], @entity.processed_stages.to_a
    assert_equal true, @entity.converted?
  end

  def test_should_extract
    @entity.processed_stages << :extract
    assert_equal [:extract], @entity.processed_stages.to_a
    assert_equal true, @entity.extracted?
  end

  def test_should_split
    @entity.processed_stages << :split
    assert_equal [:split], @entity.processed_stages.to_a
    assert_equal true, @entity.split?
  end

  def test_should_perform
    @entity.processed_stages << :perform
    assert_equal [:perform], @entity.processed_stages.to_a
    assert_equal true, @entity.performed?
  end

  def test_should_clear
    @entity.processed_stages << :split
    assert_equal [:split], @entity.processed_stages.to_a
    @entity.processed_stages = []
    assert_equal [], @entity.processed_stages.to_a
  end

  def test_should_raise_not_implemented_status
    entity_without_status = ChunksterWithoutStatus.new
    assert_raise Speech::Stages::NotImplementedError do
      entity_without_status.processing?
    end
    assert_raise Speech::Stages::NotImplementedError do
      entity_without_status.processed?
    end
    assert_raise Speech::Stages::NotImplementedError do
      entity_without_status.processing_error?
    end
  end

  def test_should_processing?
    assert_equal false, @entity.processing?
    @entity.status = Speech::State::STATUS_PROCESSING
    assert_equal true, @entity.processing?
  end

  def test_should_processed?
    assert_equal false, @entity.processed?
    @entity.status = Speech::State::STATUS_PROCESSED
    assert_equal true, @entity.processed?
  end

  def test_should_processing_error?
    assert_equal false, @entity.processing_error?
    @entity.status = Speech::State::STATUS_PROCESSING_ERROR
    assert_equal true, @entity.processing_error?
  end

  def test_set_from_other_instance
    @entity.processed_stages = [:build, :encode]
    other_entity = ChunksterWithoutStatus.new
    other_entity.processed_stages = @entity.processed_stages
    assert_equal [:build, :encode], other_entity.processed_stages.to_a
  end

end
