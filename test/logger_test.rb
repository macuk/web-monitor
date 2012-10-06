require 'minitest/autorun'
require 'web-monitor/logger'

class LoggerTest < MiniTest::Unit::TestCase
  def setup
    @config = {'log_file' => '/tmp/test.log'}
    @l = WebMonitor::Logger.new(@config)
  end

  def test_info
    @l.info('test')
    @l.close
    content = File.read(@config['log_file'])
    assert_match /INFO/, content
    assert_match /test/, content
  end
end
