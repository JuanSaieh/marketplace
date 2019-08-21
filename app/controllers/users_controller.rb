class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:show, :destroy]
  before_action :allow_action, only: [:destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'your User is now live'
    else
      render :new
    end
  end

  def show; end

  def destroy
    return  redirect_to users_path, alert: 'Permission Denied - Cannot delete another User' unless @allow_action
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully'
  end

  private
  def user_params
    params.require(:user).permit(
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

  def is_user_current_user
    @allow_action = current_user && @user.id.equal?(current_user.id)
  end

end
