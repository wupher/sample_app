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
end
