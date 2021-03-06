class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def log_out
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
  end
end
