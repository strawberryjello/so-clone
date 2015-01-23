module Voteable
  
  def votes
    self.upvotes.size - self.downvotes.size
  end

end
