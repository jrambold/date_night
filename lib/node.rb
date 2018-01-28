class Node
  attr_accessor :score,
                :movie,
                :left,
                :right

  def initialize(score, movie)
    @score = score
    @movie = movie
    @left = nil
    @right = nil
  end



end
