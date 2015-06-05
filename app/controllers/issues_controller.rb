class IssuesController < ApplicationController
  def index
    @project = Project.find params[:project_id]
    @issues = @project.issues
  end

  def new
    @project = Project.find params[:project_id]
    @issue = Issue.new(project: @project)
  end

  def create
    @project = Project.find params[:project_id]
    @issue = @project.issues.create issues_params

    redirect_to project_issues_path
  end

  def show
  end

  def edit
  end

  private

  def issues_params
    params.require(:issue).permit(:title, :kind, :status)
  end
end
