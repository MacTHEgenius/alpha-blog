class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  # GET /signup (/users/new)

  def new
    @user = User.new
  end

  # GET /users/:id/edit

  def edit
  end

  # GET /users

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # POST /users

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome aboard, #{@user.username} !"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  # /users/:id

  # GET
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # POST - PATCH
  def update
    if @user.update(user_params)
      flash[:success] = "Your infos were successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  # DELETE
  def destroy
    @user = User.find(params[:id])
    username = @user.username
    count = @user.articles.count
    @user.destroy
    flash[:danger] = "#{username}'s account and his article#{count > 1 ? 's' : ''} have been deleted"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def get_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end

    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only admins can perform this action"
        redirect_to root_path
      end
    end

end