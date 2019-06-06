class SessionsController < ApplicationController
  before_action :redirect_logged_in_user, only: [:new]
  def new
    @user = User.new
    render :new
  end

  def create
    User.find_by_credentials(
      params[:user][:user_name], 
      params[:user][:password]
    )

    if @user 
      login!(@user)
      redirect_to cats_url
    else 
      flash.now[:errors] = ['Invalid login']
      redirect_to :new 
    end

    @user.reset_session_token!  
    session[:session_token] = @user.session_token 
  end

  def destroy
     log_out!
    redirect_to cats_url
  end
end
