# == Schema Information
# Schema version: 20100524032134
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

# == Schema Information
# Schema version: 20100518155704
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#
require 'digest'

class User < ActiveRecord::Base
  #create a virtual attribute 'password'
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  EmailRegex = 
    /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #automatically create the virtual attribute 'password_confirmation'
  validates_confirmation_of :password
  validates_presence_of :password
  validates_length_of :password, :within=>4..40

  validates_presence_of :name, :email
  validates_length_of :name, :maximum => 50
  validates_format_of :email, :with=>EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

  before_save :encrypt_password

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end

  #Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  private
    def encrypt_password
      self.salt = make_salt   #别被它们的形式唬了，其实是调用了一个函数salt=
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
