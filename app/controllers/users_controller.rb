class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    byebug
    if @user.save
      redirect_to root_path, notice: 'your User is now live'
    else
      render :new
    end
  end

  def user_params
    user_params = params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :cellphone,
      :address,
      :password,
      :password_confirmation
      )
  end

  def set_user
    @user = User.find(params[:id])
  end

end
