class UsersController < ApplicationController
  def new
  	@user = User.new
  	@title = "Sign up"
  end

  def show
  	@user = User.find(params[:id])
  	@title = @user.name
  end

  def create

  	@title = "Sign up"
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to @user, :flash => { :success => "Welcome aboard!"}
  	else
  		render 'new'
  	end
  end

end
