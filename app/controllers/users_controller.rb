class UsersController < ApplicationController
  before_action :authorized?, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      cookies.delete(:redirect_after_error)
      redirect_to user_path(@user), notice: "Thanks for creating an Account"
    else
      flash.now[:alert] = "Please address the errors below"
      cookies[:redirect_after_error]  = {
        value: "true",
        expires: 60.seconds.from_now
      }
      render action: "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(params[:id], user_params)
    if @user.valid?
      redirect_to user_path(@user), notice: "You succesfully updated your profile"
    else
      flash.now[:alert] = "Please address the errors below"
      render :edit
    end
  end

  def show
    @user = current_user
    @events = Event.upcoming_events(@user.id)
  end

  protected

  def user_params
    params.require(:user).permit(
      :name,
      :email, 
      :password, 
      :password_confirmation, 
      :username, 
      :phone_number,
      :communication_preference,
      :time_zone
    )
  end
end
