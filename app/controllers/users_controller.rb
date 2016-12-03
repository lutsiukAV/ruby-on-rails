class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.group = 3
    @user.save
    render :new
  end

  def user_params
    params.require(:user).permit(:login, :password)
  end
end
