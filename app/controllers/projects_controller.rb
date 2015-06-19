class ProjectsController < ApplicationController
  before_action :require_user
  
  def index
    @projects = Project.where(user_id: session[:user_id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find params[:id]
  end

  def show
    @project = Project.find(params[:id])
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

  private

  def project_params
    params.require(:project).permit(:name, :description, :scope)
  end
end
