#btree test
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/binarysearchtree'
require './lib/node'

class Test_BinarySearchTree < Minitest::Test
  def test_btree_exists
    tree = BinarySearchTree.new()
    assert_instance_of BinarySearchTree, tree
  end

  def test_insert_include_depth_min_max_sort
    tree = BinarySearchTree.new()
    assert_instance_of BinarySearchTree, tree
    tree.insert(61, "Bill & Ted's Excellent Adventure")
    tree.insert(16, "Johnny English")
    tree.insert(92, "Sharknado 3")
    tree.insert(50, "Hannibal Buress: Animal Furnace")

    assert tree.include?(61)
    assert tree.include?(16)
    assert tree.include?(92)
    assert tree.include?(50)
    refute tree.include?(35)
    assert_equal tree.depth_of(92), 1
    assert_equal tree.depth_of(50), 2
    assert_equal tree.max, {"Sharknado 3" => 92}
    assert_equal tree.min, {"Johnny English" => 16}

    assert_equal tree.sort, [{"Johnny English"=>16},
              {"Hannibal Buress: Animal Furnace"=>50},
              {"Bill & Ted's Excellent Adventure"=>61},
              {"Sharknado 3"=>92}]
  end

  def test_load
    tree = BinarySearchTree.new()
    tree.load("./lib/movies.txt")
    assert tree.include?(34)
    assert tree.include?(84)
    assert tree.include?(10)
  end

  def test_health
    tree = BinarySearchTree.new()
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    assert_equal tree.health(0), [[98, 7, 100]]
    assert_equal tree.health(1), [[58, 6, 85]]
    assert_equal tree.health(2), [[36, 2, 28], [93, 3, 42]]
    assert_equal tree.leaves, 2
    assert_equal tree.height, 4
  end
end
