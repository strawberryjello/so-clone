class Answer < ActiveRecord::Base

  include Voteable

  belongs_to :question
  belongs_to :user

  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable
  

  validates_presence_of :body
 

  before_validation :sanitize


  def sanitize
    self.body = ActionController::Base.helpers.sanitize(self.body)
  end
end
