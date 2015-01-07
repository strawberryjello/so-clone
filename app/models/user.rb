class User < ActiveRecord::Base

  attr_accessor :password, :password_confirmation

  
  has_many :questions
  has_many :answers


  validates_presence_of :login, :password, :password_confirmation, :email
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 8..40
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password

  
end
