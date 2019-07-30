class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'your User is now live' }
      else
        format.html { render :new }
      end
    end
  end

  def user_params
    user_params = params.require(:user).permit(:first_name,
                                                  :last_name,
                                                  :email,
                                                  :cellphone,
                                                  :address
                                                  )
  end
end