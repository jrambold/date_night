class BinarySearchTree

  require_relative 'node'

  def initialize
    @root_node = nil
  end

  def insert(score, movie)
    if !@root_node
      @root_node = Node.new(score,movie)
    else
      insert_helper(@root_node, score, movie)
    end
  end

  def insert_helper(node, score, movie)
    if node.score > score
      if !node.left
        node.left = Node.new(score, movie)
      else
        insert_helper(node.left, score, movie)
      end
    else
      if !node.right
        node.right = Node.new(score, movie)
      else
        insert_helper(node.right, score, movie)
      end
    end
  end

  def include?(score)
    return include_helper(@root_node, score)
  end

  def include_helper(node, score)
    if !node
      return false
    elsif node.score == score
      return true
    elsif node.score > score
      return include_helper(node.left, score)
    else
      return include_helper(node.right, score)
    end
  end

  def depth_of(score)
    if !include?(score)
      return nil
    else
      return depth_of_helper(@root_node,score)-1
    end
  end

  def depth_of_helper(node,score)
    if node.score == score
      return 1
    elsif node.score > score
      return depth_of_helper(node.left, score) + 1
    end
  end

  def max
    if !@root_node
      return nil
    else
      return max_helper(@root_node)
    end
  end

  def max_helper(node)
    if !node.right
      return node
    else
      return max_helper(node.right)
    end
  end

  def min
    if !@root_node
      return nil
    else
      return max_helper(@root_node)
    end
  end

  def min_helper(node)
    if !node.left
      return node
    else
      return max_helper(node.left)
    end
  end

  def sort
    if !root_node
      return nil
    else
      sorted_tree = []
      sort_helper(@root_node, sorted_tree)
    end
  end

  def sort_helper(node, sorted_tree)
    if !node.left
      sort_helper(node.left, sorted_tree)
    end
    sorted_tree << node
    if !node.right
      sort_helper(node.right, sorted_tree)
    end
  end

  def load(filename)

  end

end
