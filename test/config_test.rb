require 'minitest/autorun'
require 'web-monitor/config'
require 'ostruct'

class ConfigTest < MiniTest::Unit::TestCase
  def test_file_settings
    config = WebMonitor::Config.new('test/test-config.yml')
    assert_equal 2.5, config.response_time_limit
    assert_equal 'test@domain-test.com', config.alert_mail
    assert_equal 'url-list.csv', config.urls_file
    assert_equal 'monitor.log', config.log_file
    assert_equal 1.5, config.delay
  end

  def test_default_values
    config = WebMonitor::Config.new('test/test-minimal-config.yml')
    assert_equal 3.0, config.response_time_limit
    assert_equal 'test-min@domain-test.com', config.alert_mail
    assert_equal 'urls.csv', config.urls_file
    assert_equal 'web-monitor.log', config.log_file
    assert_equal 1.0, config.delay
  end
end
