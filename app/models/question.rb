class Question < ActiveRecord::Base

  attr_accessor :tag_string
  

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :tags
  
  
  validates_presence_of :title, :text


  def add_tags new_tags
    new_tags.each do |t| 
      if !tags.exists?(:name => t.name)
        tags << t
      end
    end
  end
end
