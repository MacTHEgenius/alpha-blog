class UsersController < ApplicationController

  # GET /signup (/users/new)

  def new
    @user = User.new
  end

  # POST /users

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome aboard, #{@user.username} !"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end