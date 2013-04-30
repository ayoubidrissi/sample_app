# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before(:each)	do
  	@attr = {:name => "Sample Name", :email => "sample@example.com"}
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

end
