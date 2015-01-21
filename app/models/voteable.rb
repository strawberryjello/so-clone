module Voteable

  def init_votes
    self.votes = 0
  end

  
  def upvote
    self.votes += 1
  end

  
  def downvote
    self.votes -= 1
  end
end
