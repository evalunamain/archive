class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :login_user!, :user_session_tokens

  def current_user
    token = SessionToken.where(token: session[:session_token]).first
    return nil if token.nil?

    @cu ||= token.user
  end

  def login_user!
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    unless @user
      redirect_to new_session_url
    else
      User.transaction do
        token_string = @user.set_session_token!
        SessionToken.where(token: token_string).first.update(environment: request.env["HTTP_USER_AGENT"])
        session[:session_token] = token_string
        redirect_to cats_url
      end
    end
  end

  def user_session_tokens
    SessionToken.where(user_id: current_user.id)
  end

end
