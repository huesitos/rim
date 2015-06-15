class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :menu
  include BeforeRender
  
	private
		def menu
			if id = params[:project_id]
				@project = Project.find(id)
			elsif id = params[:id]
				@project = Project.find(id)
			else
				@project = nil
			end

			if @project
				@menu = [
					{
						name: "Info",
						path: project_path(@project),
						controller: "projects"
					},
					{
						name: "Use Cases",
						path: project_use_cases_path(@project),
						controller: "use_cases"
					},
					{
						name: "Test Cases",
						path: project_test_cases_path(@project),
						controller: "test_cases"
					},
					{
						name: "Test Runs",
						path: project_test_runs_path(@project),
						controller: "test_runs"
					},
					{
						name: "Requirements",
						path: project_requirements_path(@project),
						controller: "requirements"
					},
					{
						name: "Issues",
						path: project_issues_path(@project),
						controller: "issues"
					}
				]
			end	
		end		
end
