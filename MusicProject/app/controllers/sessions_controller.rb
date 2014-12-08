class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
      params[:user][:password])
    if @user
      log_in(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    current_user.try(:reset_session_token)
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
