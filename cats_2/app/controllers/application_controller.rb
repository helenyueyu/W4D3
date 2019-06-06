class ApplicationController < ActionController::Base
  helper_method :current_user 
  def log_out!
    current_user.reset_session_token! if current_user 
    
    session[:session_token] = nil 
    
    current_user.save!

    @current_user = nil
  end

  def current_user 
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    !!current_user 
  end

  def redirect_logged_in_user
    redirect_to cats_url if logged_in?
  end
end
