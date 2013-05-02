# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do

  before(:each)	do
  	@attr = {
      :name => "Sample Name",
      :email => "sample@example.com",
      :password => "password",
      :password_confirmation => "password"
    }
  end

  it "should create a valid user width valid attributes" do
  	User.create!(@attr)
  end

  it "should require a name" do
  	no_name_user = User.new(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end

  it "should require an email" do
  	no_email_user = User.new(@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
  		name_too_long = "a" * 50
  		name_too_long_user = User.new(@attr.merge(:name => name_too_long))
  		name_too_long_user.should_not be_valid
  end

  it "should reject invalid emails" do
  	addresses = %w[test.com test@hostname,com test@test]
  	addresses.each do |address|
  		invalid_user_email = User.new(@attr.merge(:email => address))	
  		invalid_user_email.should_not be_valid
  	end
  end
  it "should reject double email addresses" do
  	User.create!(@attr)
  	user_with_duplicate_email = User.new(@attr)
  	user_with_duplicate_email.should_not be_valid
  end	


  describe "passwords" do
    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do      
      @user.should respond_to(:password)
    end

    it "should have a confirmation password" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password confirmation" do
    it "should require a password" do
      User.new(@attr.merge(:password => "",:password_confirmation => "")).
           should_not be_valid
    end

    it "should match password confirmation" do
      User.new(@attr.merge(:password_confirmation => "157413")).
           should_not be_valid
    end

    it "should reject short password" do
      short_password = "a" * 5
      User.new(@attr.merge(:password => short_password, :password_confirmation => short_password)).
           should_not be_valid
    end

    it "should reject long passwords" do
      short_password = "a" * 50
      User.new(@attr.merge(:password => short_password, :password_confirmation => short_password)).
           should_not be_valid
    end 
  end

  describe "password encryptation" do

    before(:each) do
      @user = User.create!(@attr)
    end


    it "should have a password encrypted attribute" do
      @user.should respond_to(:encrypted_password) 
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password method" do
      it "should have has_password function" do
        @user.should respond_to(:has_password?)
      end

      it "should return true if match password" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should return false if match password" do
        @user.has_password?("invalid password").should be_false
      end
    end

    describe "authenticate method" do

      it "should exist" do
        User.should respond_to(:authenticate)
      end

      it "should return nil on mismatch pass" do 
        User.authenticate(@attr[:email],"invalid password").should be_nil
      end

      it "should return nil on mismatch email" do 
        User.authenticate("invalid@email.com",@attr[:password]).should be_nil
      end

      it "should return user on match email and pass" do 
        User.authenticate(@attr[:email],@attr[:password]).should == @user
      end
    end

  end

  

end
