class Log
  @@instance = Log.new

  def self.instance
    return @@instance
  end

  def log(name)
    @rec = Record.new({name: name})
    @rec.save
  end

  private_class_method :new
end

class SessionsController < ApplicationController
  def login
  end

  def login_attempt
    params = user_params
    authorized_user = false
    user = User.find_by_login(params[:username])
    if user && user.password == params[:password]
      authorized_user = user
    end
    if authorized_user
      session[:name] = authorized_user[:login]
      logger.info "#{session[:name]} is logged in!"
      action = [:admin, :teacher, :student]
      Log.instance.log(authorized_user[:login])
      redirect_to(:controller => action[authorized_user[:group] - 1], :action => :menu)
    else
      render :login
    end
  end

  def logout
    session[:name] = nil
    redirect_to :action => :login
  end

  def user_params
    params.permit(:username, :password)
  end
end
