class Answer < ActiveRecord::Base

  include Voteable
  

  belongs_to :question
  belongs_to :user


  validates_presence_of :body
 
 
  before_create :init_votes
  
end
