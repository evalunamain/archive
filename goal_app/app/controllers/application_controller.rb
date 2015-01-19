class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :signed_in?, :current_user

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def log_in(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
    redirect_to user_url(user)
  end

  def log_out
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def ensure_signed_in
    redirect_to new_session_url unless signed_in?
  end
end
