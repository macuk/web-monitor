require 'minitest/autorun'
require 'web-monitor/response_validator'
require 'ostruct'

class ResponseValidatorTest < MiniTest::Unit::TestCase
  def setup
    @config = OpenStruct.new(response_time_limit: 3)
    @v = WebMonitor::ResponseValidator.new(1, 200, @config)
  end

  def test_when_valid
    assert @v.valid?
  end

  def test_when_timeout
    @v.time = 10
    assert_equal false, @v.valid?
  end

  def test_when_wrong_status
    @v.status = 404
    assert_equal false, @v.valid?
  end

  def test_time_error_msg
    @v.time = 10.18315
    assert_match /Time=10.2s/, @v.error_msg
  end

  def test_status_error_msg
    @v.status = 500
    assert_match /Status=500/, @v.error_msg
  end

  def test_time_as_float
    @v.time = 0.2
    assert @v.valid?
    @v.time = 3.2
    assert_equal false, @v.valid?
  end
end
