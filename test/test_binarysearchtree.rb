#btree test
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/binarysearchtree'

class Test_BinarySearchTree < Minitest::Test
  def test_btree_exists
    tree = BinarySearchTree.new()
    assert_instance_of BinarySearchTree, tree
  end
end
