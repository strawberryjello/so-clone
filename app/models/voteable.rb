module Voteable
  
  attr_accessor :votes




  def init
    @votes = 0
  end

  def upvote
    @votes += 1
  end

  def downvote
    @votes -= 1
  end
end
