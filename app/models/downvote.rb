class Downvote < ActiveRecord::Base

  belongs_to :voteable, polymorphic: true
  belongs_to :user
  
  
  def self.cancel question_id, user_id
    downvote = Downvote.find_by(:voteable_id => question_id, :user_id => user_id)
    downvote.destroy
  end
  
end
