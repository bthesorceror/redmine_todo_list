class TasksController < ApplicationController
  unloadable
  
  accept_key_auth :feed

  before_filter :require_logged, :except => [:feed]
  before_filter :require_key, :only => [:feed]
  
  def index
    @tasks = User.current.tasks
  end
  
  def create
    task = User.current.tasks.build(:body => params[:task_body])
    if task.save
      flash[:notice] = "Task saved!"
    else
      flash[:error] = "Task could not be saved"
    end
    redirect_to(:action => :index)
  end
  
  def destroy
    task = User.current.tasks.find(params[:id])
    task.destroy
    flash[:notice] = "Task removed!"
    redirect_to(:action => :index)
  end
  
  def feed
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    @tasks = @current_user.tasks
    render :layout => false
  end
  
  private
  
  def require_logged
    @current_user = User.current
    unless @current_user.logged?
      redirect_to root_path
    end
  end
  
  def require_key
    @key = params[:key]
    @current_user = User.find_by_rss_key(@key) if @key
    unless @current_user
      render :inline => 'Invalid Key'
      return false
    end
  end

end
