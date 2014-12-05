class SessionsController < ApplicationController

  before_action :go_to_root, only: [:new, :create]

  def new
    render :new
  end

  def create
    login_user!
  end

  def destroy()
    SessionToken.find(params[:token_id]).destroy!
    redirect_to new_session_url
  end

  private
  def go_to_root
    redirect_to cats_url if current_user
  end

end
