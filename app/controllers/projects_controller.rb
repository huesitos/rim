class ProjectsController < ApplicationController
  before_action :require_user
  
  def index
    @projects = Project.where(user_id: session[:user_id]).to_a
    user = User.find(session[:user_id])
    user.projects_testing.each do |p|
      @projects << Project.find(p)
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find params[:id]
  end

  def show
    @project = Project.find(params[:id])
    @user = User.find(session[:user_id])
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = session[:user_id]

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy

    redirect_to projects_path
  end

  def new_tester
    @project = Project.find(params[:project_id])
  end

  def add_tester
    @project = Project.find(params[:project_id])
    user = User.find_by(email: params[:tester][:email])

    respond_to do |format|
      if user
        if not user.projects_testing.include? @project._id
          user.projects_testing << @project._id
          user.save
          format.html { redirect_to project_new_tester_path(@project), 
            notice: "Tester added to project.",
            alert: 'success' }
        else
          format.html { redirect_to project_new_tester_path(@project), 
            notice: "Tester is already in the project.",
            alert: 'warning' }
        end
      else
        format.html { redirect_to project_new_tester_path(@project),
          notice: "Tester couldn't be added. User not found.", 
          alert: 'danger'}
      end
    end
  end

  private

    def project_params
      params.require(:project).permit(:name, :description, :scope)
    end
end
