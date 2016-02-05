class Question < ActiveRecord::Base

  include Voteable
  include Mentionable


  attr_accessor :tag_string


  belongs_to :user

  has_many :answers, dependent: :destroy

  has_many :upvotes, as: :voteable
  has_many :downvotes, as: :voteable

  has_and_belongs_to_many :tags


  validates_presence_of :title, :text


  before_validation :sanitize
  before_save :substitute_mentions


  def substitute_mentions
    self.text = parse_mentions self.text
  end


  def sanitize
    self.title = ActionController::Base.helpers.sanitize(self.title)
    self.text = ActionController::Base.helpers.sanitize(self.text)
  end


  # consider putting in a Taggable module instead
  def add_tags new_tags
    new_tags.each do |t|
      tags << t unless tags.exists?(:name => t.name)
    end
  end

end
