class TeacherController < ApplicationController
  before_filter :need_login
  def menu
  end

  def change_password
    @user = User.find_by_login(session[:name])
    @user.password = params[:password]
    @user.save
    render :menu
  end

  def add_course
    @user = User.find_by_login(session[:name])
    p = params.permit(:name, :hours)
    p[:user_id] = @user.id
    @course = Course.new(p)
    @course.save
    render :menu
  end

  def estimate_list
    g = Grade.all
    @grade = []
    g.each do |grd|
      if grd.mark == 0
        usr = User.find(grd.user_id)
        crs = Course.find(grd.course_id)
        @grade.append({login: usr[:login], course: crs[:name], uid: usr[:id], cid: crs[:id]})
      end
    end
    render :estimate_list
  end

  def estimate_page
    p = params.permit(:login, :course)
    session[:student] = p[:login]
    session[:course] = p[:course]
    render :estimate_page
  end

  def estimate
    p = params.permit(:mark, :comment)
    @grades = Grade.all
    @grades.each do |g|
      if g.course_id == session[:course].to_i && g.user_id == session[:student].to_i
        id = g.id
        Grade.update(id, :mark => p[:mark], :comment => p[:comment])
      end
    end
    session[:course] = nil
    session[:student] = nil
    redirect_to(:action => :menu)
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
