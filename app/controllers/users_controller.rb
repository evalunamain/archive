class UsersController < ApplicationController

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

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
