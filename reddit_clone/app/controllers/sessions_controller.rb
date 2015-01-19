class SessionsController < ApplicationController

  def new
    render :new
  end


  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    unless @user
      flash.now[:errors] = "Invalid username or password"
      render :new
    else
      log_in!(@user)
    end
  end

  def destroy
    user = User.find_by(session_token: session[:token])
    log_out!(user)
  end



end
