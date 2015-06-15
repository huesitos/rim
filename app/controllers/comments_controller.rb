class CommentsController < ApplicationController
  def new
    @project = Project.find params[:project_id]
    @issue = @project.issues.find params[:issue_id]
    @comment = Comment.new(issue: @issue)
  end

  def create
    @project = Project.find params[:project_id]
    @issue = @project.issues.find params[:issue_id]
    @comment = @issue.comments.create(body: comment_params[:body], date: Date.today)

    redirect_to project_issue_path @project, @issue
  end

  def destroy
    issue = Issue.find(params[:issue_id])
    issue.comments.find(params[:id]).destroy

    redirect_to project_issue_path(params[:project_id], params[:issue_id]), notice: 'Comment was successfully destroyed.', alert: 'success'
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
