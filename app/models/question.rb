class Question < ActiveRecord::Base

  attr_accessor :tag_string
  

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :tags
  
  
  validates_presence_of :title, :text
end
