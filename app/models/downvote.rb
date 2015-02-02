class Downvote < ActiveRecord::Base

  belongs_to :voteable, polymorphic: true
  belongs_to :user
  
  
  def self.cancel voteable_id, user_id
    downvote = Downvote.find_by(:voteable_id => voteable_id, :user_id => user_id)
    downvote.destroy
  end
  
end
