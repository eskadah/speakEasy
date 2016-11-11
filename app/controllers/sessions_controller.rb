class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.password_digest && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: 'You have successfully logged in'
    else
      redirect_to :root, alert: 'Incorrect username or password '
    end
  end

  def destroy
    reset_session
    redirect_to :root, notice: 'You have successfully logged out'
  end
end
