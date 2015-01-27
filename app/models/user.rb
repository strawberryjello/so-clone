require 'digest/sha1'
require 'securerandom'

class User < ActiveRecord::Base

  include Rails.application.routes.url_helpers
  

  attr_accessor :password, :password_confirmation

  
  has_many :questions
  has_many :question_upvotes, through: :questions, source: :upvotes
  has_many :question_downvotes, through: :questions, source: :downvotes
  
  has_many :answers
  has_many :answers_upvotes, through: :answers
  has_many :answers_downvotes, through: :answers


  validates_presence_of :login, :password, :password_confirmation, :email
  validates_length_of :password, :within => 8..40
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password
  validates_format_of :login, :with => /\A[a-z0-9._-]{3,40}\Z/i


  before_create :trim_username


  def self.authenticate login, pass
    user = self.find_by login: login
    return nil if user.nil?
    return user if self.encrypt(pass, user.salt) == user.hashed_password
  end

  
  def password= pass
    @password = pass
    # generates 32-character string
    self.salt = SecureRandom.hex
    self.hashed_password = User.encrypt @password, self.salt
  end

  def send_new_password
    # generates 8-character string
    new_pass = SecureRandom.hex 4
    self.password = self.password_confirmation = new_pass
    self.save
    Notifier.forgot_password(self.email, new_pass).deliver_now
  end


  # has own method for easier testing
  def trim_username
    login.strip! if login
  end


  def profile_url
    profile_user_path(self)
  end


  protected

  def self.encrypt pass, salt
    Digest::SHA1.hexdigest pass + salt
  end
end
