class Question < ActiveRecord::Base

  belongs_to :user

  has_many :answers, dependent: :destroy
  
  
  validates :title, presence: true
  validates :text, presence: true
end
