class AdminController < ApplicationController
  before_filter :need_login

  def menu
  end

  def show_all
    @users = User.all
    render :show_all
  end

  def delete_user
    @user = User.find(params.require(:id))
    @user.delete
    redirect_to(:action => :show_all)
  end

  def create_teacher
    @user = User.new(user_params)
    @user.password = '123'
    @user.group = 2
    @user.save
    redirect_to(:action => :menu)
  end

  def user_params
    params.permit(:login)
  end

  def system_log
    @rec = Record.all
    render :system_log
  end

  private
  def need_login
    unless logged_in?
      redirect_to(:controller => :sessions, :action => :login)
    end
  end

  private
  def logged_in?
    !(session[:name] == nil)
  end
end
