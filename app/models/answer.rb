class Answer < ActiveRecord::Base

  include Voteable
  include Mentionable

  belongs_to :question
  belongs_to :user

  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable


  validates_presence_of :body


  before_validation :sanitize
  before_save :substitute_mentions


  def substitute_mentions
    self.body = parse_mentions self.body
  end


  def sanitize
    self.body = ActionController::Base.helpers.sanitize(self.body)
  end
end
