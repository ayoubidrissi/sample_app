require 'spec_helper'

describe UsersController do
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
      get :show, :id => @user.id
      response.should be_success
    end

    it "should contain the right title" do
      get :show, :id => @user.id
      response.should have_selector('title',:content => @user.name)

    end

  end

  describe "POST 'create'" do
    describe "Failure" do
      before(:each) do
        @attr = {:name => "",:email => "invalide@email", :password => "123456", :password_confirmation => "654321"}
      end
      
      it "should have the right title" do
        post :create,:user => @attr
        response.should have_selector('title',:content => "Sign up")
      end
      it "should render new" do
        post :create,:user => @attr
        response.should render_template('new')

      end
      it "should not create user" do
        lambda do
          post :create,:user => @attr          
        end.should_not change(User,:count)

      end

    end
  end
end
