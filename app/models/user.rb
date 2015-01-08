require 'digest/sha1'
require 'securerandom'

class User < ActiveRecord::Base

  attr_accessor :password, :password_confirmation

  
  has_many :questions
  has_many :answers


  validates_presence_of :login, :password, :password_confirmation, :email
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 8..40
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password


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


  protected

  def self.encrypt pass, salt
    Digest::SHA1.hexdigest pass + salt
  end
end
