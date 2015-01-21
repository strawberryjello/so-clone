class Downvote < ActiveRecord::Base

  belongs_to :voteable, polymorphic: true
  belongs_to :user
  
end
