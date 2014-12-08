class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :require_login

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in(user)
    @current_user = user
    session[:session_token] = user.reset_session_token
    redirect_to bands_url
  end

  def signed_in?
    !!current_user
  end

  def log_out
    current_user.try(:reset_session_token)
    session[:session_token] = nil
  end

  def require_login
    unless signed_in?
      redirect_to new_session_url
    end
  end


end
