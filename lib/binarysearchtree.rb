class BinarySearchTree

  require_relative 'node'

  def initialize
    @root_node = nil
    @total_nodes = 0
  end

  def insert(score, movie)
    @total_nodes += 1
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
    else
      return depth_of_helper(node.right, score) +1
    end
  end

  def max
    if !@root_node
      return nil
    else
      node = max_helper(@root_node)
      return {node.movie => node.score}
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
      node = min_helper(@root_node)
      return {node.movie => node.score}
    end
  end

  def min_helper(node)
    if !node.left
      return node
    else
      return min_helper(node.left)
    end
  end

  def sort
    if !@root_node
      return nil
    else
      sorted_tree = []
      sorted_tree = sort_helper(@root_node)
    end
    return sorted_tree
  end

  def sort_helper(node)
    sorted_tree = []
    if node.left
      sorted_tree = sort_helper(node.left)
    end
    sorted_tree << {node.movie => node.score}
    if node.right
      sorted_tree += sort_helper(node.right)
    end
    return sorted_tree
  end

  def load(filename)
    movies = []
    movie_file = IO.readlines(filename)
    movie_file.each do |movie_file|
      to_load =  movie_file.split(", ",2)
      movies << [to_load[0].to_i, to_load[1]]
    end
    movies.each do |movies|
      insert(movies[0],movies[1])
    end
  end

  def health(depth)
    #for each node at depth
    dnodes = depth_helper(depth, @root_node)
    health_nodes = []
    dnodes.each do |dnodes|
      health_nodes << [dnodes.score, child_count(dnodes), health_helper(dnodes)]
    end
    return health_nodes
  end

  def depth_helper(depth, node)
    node_arr = []
    if depth == 0
      node_arr << node
    elsif depth > 0
      if node.left
        node_arr = depth_helper(depth-1, node.left)
      end
      if node.right
        node_arr += depth_helper(depth-1, node.right)
      end
    end
    return node_arr
  end

  def health_helper(node)
    children = child_count(node)
    status = 100*children/@total_nodes
    return status
  end

  def child_count(node)
    if node
      return 1+child_count(node.left)+child_count(node.right)
    else
      return 0
    end
  end

  def leaves
    return leaves_helper(@root_node)
  end

  def leaves_helper(node)
    leaf_count = 0
    if !node.left && !node.right
      return 1
    end
    if node.left
      leaf_count += leaves_helper(node.left)
    end
    if node.right
      leaf_count += leaves_helper(node.right)
    end
    return leaf_count
  end

  def height
    return height_helper(@root_node)-1
  end

  def height_helper(node)
    if !node
      return 0
    else
      left = height_helper(node.left)+1
      right = height_helper(node.right)+1
      if right > left
        return right
      else
        return left
      end
    end
  end

  def delete(score)
    delete_helper(score, @root_node)
  end

  def delete_helper(score, node)
    if !node
      return nil
    elsif node.score == score
      if node.left && node.right
        successor = min_helper(node.right)
        node.score = successor.score
        node.movie = successor.movie
        delete_helper(successor.score, successor)
      elsif node.left #node is not passing the new value up
        node = node.left
      elsif node.right
        node = node.right
      else
        node = nil
      end
    elsif node.score > score
      delete_helper(score, node.left)
    else
      delete_helper(score, node.right)
    end
  end

end
