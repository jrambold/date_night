#node test
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class Test_BinarySearchTree < Minitest::Test
  def test_node_exists
    node = Node.new(50,"hello world")
    assert_instance_of Node, node
    assert_equal node.score, 50
    assert_equal node.movie, "hello world"
    refute node.left
    refute node.right
  end


end
