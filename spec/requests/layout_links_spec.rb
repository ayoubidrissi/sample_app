require 'spec_helper'

describe "LayoutLinks" do
  it "should have a home apage at '/'" do
  	get '/'
  	response.should have_selector('title', :content => 'Home')
  end 

  it "should have a contact page at '/contact'" do
  	get '/contact'
  	response.should have_selector('title', :content => 'Contact')
  end

  it "should have a help page at '/help'" do
  	get '/help'
  	response.should have_selector('title', 
  		:content => 'Help')
  end

  it "should have a signup at /signup" do
  	get '/signup'
  	response.should have_selector('title', :content => 'Sign up')
  end

  it "should have working links" do
      visit root_path
      response.should have_selector('title', :content =>  "Home")
      click_link "about"
      response.should have_selector('title', :content => 'About')
      response.should have_selector('a[href="/"]>img')
    end
end
