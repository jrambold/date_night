#btree test
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/binarysearchtree'
require './lib/node'

class Test_BinarySearchTree < Minitest::Test
  def setup
    @tree = BinarySearchTree.new()
    assert_instance_of BinarySearchTree, @tree
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
    @tree.insert(8, "hello")
    @tree.insert(9, "world")
  end

  def test_btree_exists
    tree = BinarySearchTree.new()
    assert_instance_of BinarySearchTree, tree
  end

  def test_insert_include
    assert @tree.include?(61)
    assert @tree.include?(16)
    assert @tree.include?(92)
    assert @tree.include?(50)
    assert @tree.include?(8)
    refute @tree.include?(35)
  end

  def test_depth
    assert_equal @tree.depth_of(92), 1
    assert_equal @tree.depth_of(50), 2
  end

  def test min_max
    assert_equal @tree.max, {"Sharknado 3" => 92}
    assert_equal @tree.min, {"hello" => 8}
  end

  def test_sort
    assert_equal @tree.sort, [{"hello"=>8},
              {"world"=>9},
              {"Johnny English"=>16},
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

  def test_leaves
    assert_equal @tree.leaves, 3
  end

  def test_height
    assert_equal @tree.height, 3
  end

  def test_delete
    tree = BinarySearchTree.new()
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")
    tree.delete(36)#single right child
    refute tree.include?(36)
    assert tree.include?(58)

    tree.delete(86)#single left child
    refute tree.include?(86)

    tree.delete(58)#sibling delete and rearrange
    refute tree.include?(58)
    assert tree.depth_of(69), 1

    tree.delete(98)#root node delete

    assert_equal tree.sort, [{"Charlie's Country"=>38},
                    {"Collateral Damage"=>69},
                    {"Bill & Ted's Excellent Adventure"=>93}]

    tree.delete(38)#no children delete
    assert_equal tree.sort, [{"Collateral Damage"=>69},
                    {"Bill & Ted's Excellent Adventure"=>93}]
  end
end
