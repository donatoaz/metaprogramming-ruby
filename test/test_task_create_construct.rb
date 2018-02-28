require 'minitest/autorun'
require 'minitest/color'
require_relative '../tasks/task_create_construct'


class TestConStruct < MiniTest::Test
  def setup; end

  # Don't know why but this needs to be outside of method definition
  Product = ConStruct.new(:id, :name)

  def test_basic_construct_creation
    prod = Product.new(123, 'Ruby Book')
    assert_equal prod.name, 'Ruby Book'
    assert_equal prod.id, 123
  end

  Order = ConStruct.new(:id, :name) do
    def to_s
      "Order \##{id} is named #{name}"
    end
  end

  def test_pass_block_to_construct
    ord = Order.new(456, 'Pedido')
    assert ord.respond_to? :to_s
    assert_equal ord.to_s, 'Order #456 is named Pedido'
  end
end
