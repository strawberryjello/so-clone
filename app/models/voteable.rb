module Voteable
  
  def votes
    return self.upvotes.size - self.downvotes.size
  end

end
