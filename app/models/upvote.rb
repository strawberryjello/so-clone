class Upvote < ActiveRecord::Base

  belongs_to :voteable, polymorphic: true
  belongs_to :user


  def self.cancel voteable_id, user_id
    upvote = Upvote.find_by(:voteable_id => voteable_id, :user_id => user_id)
    upvote.destroy
  end

end
