class IssuesController < ApplicationController
  def index
    @issues = Project.find(params[:project_id]).issues
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

  def destroy
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue.destroy
    redirect_to project_issues_path params[:project_id]
  end

  private

  def issues_params
    params.require(:issue).permit(:title, :kind, :status)
  end
end
