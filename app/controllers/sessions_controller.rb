class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      log_in(user)
    else
      flash.now[:errors] = "Invalid username/password"
      render :new
    end
  end

  def destroy
    log_out
  end
end
