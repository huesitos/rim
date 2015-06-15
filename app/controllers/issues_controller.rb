class IssuesController < ApplicationController
  def index
    @issues = Project.find(params[:project_id]).issues
    @statuses = Status.all.pluck(:name)
    @labels = Label.all.pluck(:name)
  end

  def new
    @project = Project.find params[:project_id]
    @issue = Issue.new(project: @project)
    @labels = Label.all.pluck(:name)
  end

  def create
    @project = Project.find params[:project_id]
    identifier = Issue.get_next_identifier(project_id: @project._id)

    identifier.inspect

    @issue = @project.issues.create(
      title: issues_params[:title],
      description: issues_params[:description],
      identifier: identifier)

    @issue.status = Status.find_by(name: 'Open')
    @issue.save

    if params[:labels]
      params[:labels].each do |label|
        @issue.labels << Label.find_by(name: label)
      end
      redirect_to project_issues_path
    else
      redirect_to new_project_issue_path, notice: 'A label must be selected', alert: 'danger'
    end
  end

  def show
    @project = Project.find params[:project_id]
    @issue = @project.issues.find(params[:id])
    @comments = @issue.comments
  end

  def edit
    @project = Project.find params[:project_id]
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue_labels = @issue.labels.pluck(:name)
    @labels = Label.all.pluck(:name)
    @statuses = Status.all.pluck(:name)
    @edit = true
  end

  def update
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue.status = Status.find_by(name: issues_params[:status])

    if @issue.save
      if @issue.update(title: issues_params[:title], description: issues_params[:description])
        redirect_to project_issue_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue.destroy
    redirect_to project_issues_path params[:project_id]
  end

  private

  def issues_params
    params.require(:issue).permit(:title, :status, :description)
  end
end
