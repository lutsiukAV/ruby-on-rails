class StudentController < ApplicationController
  before_filter :need_login
  def menu
  end

  def course_list
    @course = Course.all
    @grd = Grade.all
    @crs = []
    student = User.find_by_login(session[:name])
    @course.each do |c|
      u = User.find(c.user_id)
      exists = false
      @grd.each do |g|
        if g.course_id == c[:id] && g.user_id == student[:id]
          exists = true
        end
      end
      unless exists
      @crs.append({name: c[:name], user: u[:login], id: c[:id]})
      end
    end
    render :course_list
  end

  def follow_course
    p = params.permit([:cid])
    u = User.find_by_login(session[:name])
    @grade = Grade.new({user_id: u[:id], course_id: p[:cid], mark: 0, comment: ''})
    @grade.save
    redirect_to(:action => :menu)
  end

  def view_grades
    @grds = Grade.all
    @gr = []
    u = User.find_by_login(session[:name])
    @grds.each do |g|
      if g[:user_id] == u[:id]
        c = Course.find(g[:course_id])
        @gr.append({crs: c[:name], mark: g[:mark], comment: g[:comment]})
      end
    end
    render :view_grades
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
