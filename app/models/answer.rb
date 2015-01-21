class Answer < ActiveRecord::Base

  belongs_to :question
  belongs_to :user

  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable
  

  validates_presence_of :body
 
 
end
