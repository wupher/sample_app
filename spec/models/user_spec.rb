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

require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :email => "value_for@email.ok",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  it "should require a name" do
    no_name_user = User.new(@valid_attributes.merge(:name=>''))
    no_name_user.should_not be_valid  #i.e no_name_user.valid?.should_not == true
  end

  it "should require an email address" do
    no_email_user = User.new(@valid_attributes.merge(:email=>''))
    no_email_user.should_not be_valid
  end


  it "should reject names that are too long" do
    long_name = "a"*51 #name shoud be less than 50
    long_name_user = User.new(@valid_attributes.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w'user@foo.com The_user@Foo.bar.org first.last@foo.jp'
    addresses.each do |address|
      valid_email_user = User.new(@valid_attributes.merge(:email=>address))
      valid_email_user.should be_valid
    end
  end


  it "should reject the invalid email addresses" do
    addresses = %w'user@foo,com user_at_foo_bar example@foo.'
    addresses.each do |address|
      invalid_email_user = User.new(@valid_attributes.merge(:email=>address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses identical up to case" do
    upcased_email = @valid_attributes[:email].upcase
    User.create!(@valid_attributes.merge(:email=>upcased_email))
    user_with_duplicate_email = User.new(@valid_attributes)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    it "should require a password" do
      User.new(@valid_attributes.merge(:password=>"", :password_confirmation=>"")).
      should_not be_valid
    end
  end

  describe "password encryption" do
    before (:each) do
      @user = User.create!(@valid_attributes)
    end
    
    it "should have an encryption password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "authenticate method" do
      
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@valid_attributes[:email],'wrongpass')
        wrong_password_user.should be_nil
      end
    
      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com.cn", @valid_attributes[:password])
        nonexistent_user.should be_nil
      end

      it "should return THE user on email/password match" do
        matching_user = User.authenticate(@valid_attributes[:email],@valid_attributes[:password])
        matching_user.should == @user
      end
    end
  end
end
