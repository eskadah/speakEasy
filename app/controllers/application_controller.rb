class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorized?
   return true if current_user
   redirect_to(:root,:alert => 'You need to be logged in to view this page')
  end

  helper_method :current_user,:authorized?



end
