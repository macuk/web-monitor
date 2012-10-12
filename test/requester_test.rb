require 'minitest/autorun'
require 'minitest/mock'
require 'web-monitor/requester'
require 'ostruct'

class RequesterTest < MiniTest::Unit::TestCase
  def setup
    @config = OpenStruct.new(response_time_limit: 3)
    @r = WebMonitor::Requester.new(@config)
  end

  def test_check_200
    @r.check 'https://www.google.pl'
    assert @r.time < 1.0
    assert_equal 200, @r.status
  end

  def test_check_404
    @r.check 'http://www.google.pl/abc'
    assert @r.time < 1.0
    assert_equal 404, @r.status
  end

  class MyBenchmark
    def measure; sleep 5; end
  end

  def test_timeout
    config = OpenStruct.new(response_time_limit: 0.5)
    r = WebMonitor::Requester.new(config)
    r.benchmark = MyBenchmark.new
    r.check 'https://www.google.pl'
    assert_equal 1.5, r.time
    assert_equal 0, r.status
  end
end
