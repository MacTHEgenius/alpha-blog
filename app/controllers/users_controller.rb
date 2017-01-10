class UsersController < ApplicationController

  # GET /signup (/users/new)

  def new
    @user = User.new
  end

  # GET /users/:id/edit

  def edit
    @user = User.find(params[:id])
  end

  # GET /users

  def index
    @users = User.all
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

  # /users/:id

  # GET
  def show
    @user = User.find(params[:id])
  end

  # POST - PATCH
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your infos were successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end



end