require 'minitest/autorun'
require_relative '../tasks/task_create_tap'

class TestTap < MiniTest::Test
  def setup
    @klass = Klass.new
  end

  def test_my_tap_is_chainable
    assert_equal @klass, @klass.my_tap { |x| x }
  end

  def test_my_tap_calls_given_block
    @klass.instance_variable_set :@testvar, false
    @klass.my_tap { |x| x.instance_variable_set :@testvar, true }

    assert @klass.instance_variable_get :@testvar
  end

  def test_my_tap_cannot_directly_access_instance_variables
    @klass.instance_variable_set :@var1, 10
    assert_output(/^teste: $/) { @klass.my_tap { print "teste: #{@var1}" } }
  end

  def test_tap2_can_directly_access_instance_variables
    @klass.instance_variable_set :@var1, 10
    assert_output(/^teste: 10$/) { @klass.tap2 { print "teste: #{@var1}" } }
  end

  def test_tap2_can_directly_call_private_method
    @klass.instance_variable_set :@var1, 10
    assert_output(/^Private$/) { @klass.tap2 { print bar } }
  end
end
