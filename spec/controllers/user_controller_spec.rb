require 'spec_helper'

describe UserController do
  render_views
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
    	get 'new'
    	response.should have_selector('title', :content => 'Sign up')
    	
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should be success" do
      get :show, :id => 32
      response.should be_success
    end
  end

end
