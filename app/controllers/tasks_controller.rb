class TasksController < ApplicationController
  unloadable
  
  accept_key_auth :feed, :destroy

  before_filter :require_login
  
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
    if params[:key]
      render :text => "Task Removed!", :status => 200
    else  
      flash[:notice] = "Task removed!"
      redirect_to(:action => :index)
    end
  end
  
  def feed
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    @tasks = User.current.tasks
    render :layout => false
  end

end
