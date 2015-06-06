class CommentsController < ApplicationController
  def new
    @project = Project.find params[:project_id]
    @issue = @project.issues.find params[:issue_id]
    @comment = Comment.new(issue: @issue)
  end

  def create
    @project = Project.find params[:project_id]
    @issue = @project.issues.find params[:issue_id]
    @comment = @issue.comments.create(comment_params)

    redirect_to project_issue_path @project, @issue
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
