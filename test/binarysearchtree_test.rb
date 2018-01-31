#btree test
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/binarySearchTree'

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

  def test_max
    assert_equal @tree.max, {"Sharknado 3" => 92}
  end

  def test_min
    assert_equal @tree.min, {"hello" => 8}
  end

  def test_sort
    expected = [{"hello"=>8},
              {"world"=>9},
              {"Johnny English"=>16},
              {"Hannibal Buress: Animal Furnace"=>50},
              {"Bill & Ted's Excellent Adventure"=>61},
              {"Sharknado 3"=>92}]
    assert_equal expected, @tree.sort
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
    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
    assert_equal 2, tree.leaves
    assert_equal 4, tree.height
  end

  def test_leaves
    assert_equal 3, @tree.leaves
  end

  def test_height
    assert_equal 3, @tree.height
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

    expected = [{"Charlie's Country"=>38},
                {"Collateral Damage"=>69},
                {"Bill & Ted's Excellent Adventure"=>93}]
    assert_equal expected, tree.sort

    tree.delete(38)#no children delete
    expected = [{"Collateral Damage"=>69},
                {"Bill & Ted's Excellent Adventure"=>93}]
    assert_equal expected, tree.sort
  end
end
