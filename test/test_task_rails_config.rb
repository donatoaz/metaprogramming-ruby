require 'minitest/autorun'
require 'minitest/color'
require_relative '../tasks/task_rails_config'


class TestApplication < MiniTest::Test
  def test_add_single_config_var
    TestApp::Application.configure do
      # Code is not reloaded between requests
      config[:cache_classes] = true

      # Full error reports are disabled and caching is turned on
      config[:consider_all_requests_local]       = false
      config[:action_controller]                 = true

      # ...
    end


    assert_equal true, TestApp::Application.conf(:cache_classes)
  end
end
