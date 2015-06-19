class IssuesController < ApplicationController
  before_action :set_labels, only: [:index, :new, :edit]
  before_action :set_statuses, only: [:index, :edit]
  before_action :require_user

  def index
    query = {project_id: params[:project_id]}
    if params[:labels] then query[:label_ids] = { "$in" => params[:labels]} end
    if params[:status] 
      if params[:status] != "All"
        query[:status] = params[:status]
      end
    end

    @issues = Issue.where(query)
  end

  def new
    @project = Project.find params[:project_id]
    @issue = Issue.new(project: @project)
  end

  def create
    @project = Project.find params[:project_id]
    identifier = Issue.get_next_identifier(project_id: @project._id)

    @issue = @project.issues.create(
      title: issues_params[:title],
      description: issues_params[:description],
      identifier: identifier,
      user_id: @project.user.id)

    @issue.status = Status.find_by(name: 'Open')
    @issue.save

    if params[:labels]
      params[:labels].each do |label|
        @issue.labels << Label.find(label)
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
    @issue_labels = @issue.labels.pluck(:_id)
    @edit = true
  end

  def update
    @issue = Project.find(params[:project_id]).issues.find(params[:id])
    @issue.status = Status.find(issues_params[:status])

    if @issue.save
      if @issue.update(title: issues_params[:title], description: issues_params[:description])
        redirect_to project_issue_path
      else
        render 'edit'
      end
    end
  end

  private

    def set_labels
      @labels = Label.all.pluck(:name, :_id)
    end

    def set_statuses
      @statuses = Status.all.pluck(:name, :_id)
    end

    def issues_params
      params.require(:issue).permit(:title, :status, :description)
    end
end
