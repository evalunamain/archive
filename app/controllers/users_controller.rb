class UsersController < ApplicationController

  before_action :go_to_root, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.password = user_params[:password]

    if @user.save
      login_user!
    else
      render :new
    end
  end

  def show
    render :new
  end

  private

  def go_to_root
    redirect_to cats_url if current_user
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
