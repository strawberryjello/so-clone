class Question < ActiveRecord::Base

  has_many :answers
  
  
  validates :title, presence: true
  validates :text, presence: true
end
