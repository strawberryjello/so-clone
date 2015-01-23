class Question < ActiveRecord::Base

  include Voteable
  

  attr_accessor :tag_string
  

  belongs_to :user

  has_many :answers, dependent: :destroy
  
  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable
  
  has_and_belongs_to_many :tags
  
  
  validates_presence_of :title, :text


  before_validation :sanitize


  def sanitize
    self.title = ActionController::Base.helpers.sanitize(self.title)
    self.text = ActionController::Base.helpers.sanitize(self.text)
  end


  def add_tags new_tags
    new_tags.each do |t|
      sanitized = ActionController::Base.helpers.sanitize(t)
      if !tags.exists?(:name => sanitized.name)
        tags << sanitized
      end
    end
  end

end
