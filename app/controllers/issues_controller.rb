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
    issue_status = { 1 => 'Open', 2 => 'fixing', 3 => 'Closed' }

    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue_status = issue_status[@issue.status]
    puts @issue_status
  end

  def edit
    @project = Project.find params[:project_id]
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @edit = true
  end

  def update
    issue_status = {"Open" => 1, "Fixing" => 2, "Closed" => 3}
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue.status = issue_status[params[:issue][:status]]
    params[:issue][:status] = issue_status[params[:issue][:status]]
    puts params
    if @issue.update(issues_params)
      redirect_to project_issue_path
    else
      render 'edit'
    end
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
