class UsersController < ApplicationController
  def index
    @users = User.includes(:posts)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  # def create
  #   @user = current_user, notice: 'User created successfully.'
  # end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :photo, :bio, :email, :password, :password_confirmation, :current_password)
  end
end
