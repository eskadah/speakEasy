class OAuthSessionsController < ApplicationController
  before_action :verify_oauth_session, only: [:register]

  def create
  	user = User.find_or_create_with_auth_hash(request.env["omniauth.auth"])
  	if user.new_record?
       session["oauth_user"] = user.as_json(only: [:email, :name, :github_id, :username])
  	   redirect_to action: :register
  	else
  	  session[:user_id] = user.id
  	  redirect_to user, notice: 'You have successfully logged in'
  	end
  end

  def register
    render locals: { user: @user, oauth_errors: session.delete(:oauth_errors) }
  end

  def complete_registration
    user = User.new(user_params)
    validator = OAuthUserValidator.new(user)
    if validator.valid?
      user.save(validate: false)
      reset_session
      session[:user_id] = user.id
      redirect_to user, notice: 'You have successfully registered'
    else
      session[:oauth_errors] = validator.errors.full_messages
      redirect_to action: :register, alert: "There are errors below"
    end
  end

  protected

  def verify_oauth_session
    if oauth_user = session["oauth_user"]
      @user = User.new(
        name: oauth_user["name"],
        email: oauth_user["email"],
        github_id: oauth_user["github_id"],
        username: oauth_user["username"]
      )
    else
      not_found
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email, 
      :username, 
      :time_zone,
      :github_id
    )
  end
end
