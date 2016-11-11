class UsersController < ApplicationController
  before_action :authorized?, :except => [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Thanks for creating an Account"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
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
      :time_zone
    )
  end
end
