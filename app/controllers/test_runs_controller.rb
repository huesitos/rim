class TestRunsController < ApplicationController
  before_action :set_test_run, except: [:create, :new, :index]
  before_action :set_test_cases, only: [:new, :index]
  before_action :set_project
  before_action :require_user

  # GET /test_runs
  # GET /test_runs.json
  def index
    query = {project_id: @project._id}
    if params[:commit] == "Today" then query[:date] = Date.today end
    if params[:date]
      date = Date.parse(params[:date]) rescue nil
      if date then  query[:date] = date end
    end

    @test_runs = TestRun.where(query)
  end

  # GET /new
  def new
    @test_run = TestRun.new()
  end

  # GET /test_runs/1
  # GET /test_runs/1.json
  def show
    @tester = User.find(@test_run.tester)
  end

  # GET /test_run/:id/run_test/:identifier
  # Retrieves next test case to run.
  # If there are no more test cases to run, it redirects to the
  # test_run show page to display the result of the test run
  def test_run
    identifier = @test_run.next_test()

    respond_to do |format|
      if identifier
        format.html { redirect_to project_test_run_run_test_path(
          @project, 
          @test_run, 
          identifier: identifier)}
      else
        format.html { redirect_to project_test_run_path(@project, @test_run), 
            notice: 'Test run finished successfully.', alert: 'success' }
      end
    end
  end

  # GET /test_run/:id/run_test/:identifier
  # Run test case page displaying test case info and form to give result
  def run_test
    @test_case = TestCase.find_by(identifier: params[:identifier], project_id: @project._id)
  end

  # PATCH /test_run/:id/run_test/:identifier/:result
  # Sets the result of the test_run on the test_case :identifier
  def result
    report = @test_run.get_report(params[:identifier])
    report.update(result: params[:commit], comment: params[:comment])

    # Update the summary counts
    Summary.update_summary(@test_run.summary, params[:commit])

    if params[:commit] == "Failed"
      redirect_to project_test_run_new_issues_path(@project, @test_run, report)
    else
      redirect_to project_test_run_test_run_path(@project, @test_run)
    end
  end

  # GET /test_run/:id/new_issues/:report
  # Form to create new issues after marking a report as failed
  def new_issues
    @report = @test_run.reports.find(params[:report])
    @labels = Label.all.pluck(:name, :_id)
  end

  # POST /test_run/:id/create_issues/:report
  # Create the new issues and associate them with a report
  def create_issues
    report = @test_run.reports.find(params[:report])
    issue = report.issues.build(
      title: params[:issue][:title], 
      description: params[:issue][:description], 
      identifier: Issue.get_next_identifier(@project.id),
      project_id: @project.id,
      status_id: Status.find_by(name: 'Open').id)
    params[:issue][:labels].delete("")

    params[:issue][:labels].each do |label|
      issue.labels << Label.find(label)
    end

    if issue.save
      if params[:commit] == "Continue"
        redirect_to project_test_run_new_issues_path(@project, @test_run, report)
      else
        redirect_to project_test_run_test_run_path(@project, @test_run)
      end
    else
      redirect_to(
        project_test_run_new_issues_path(@project, @test_run, report),
        notice: "Issue couldn't be saved. Remember to add the issue's label and title.",
        alert: "danger")
    end
  end

  # POST /test_runs
  # POST /test_runs.json
  def create
    @test_run = TestRun.new(date: DateTime.now, 
      project_id: params[:project_id],
      tester: session[:user_id])

    @test_run.summary = Summary.new(
      passed: 0, 
      skipped: 0, 
      failed: 0, 
      total: 0)

    # If specific test cases where listed, then create a test run with a report object for each of the test cases
    # If all test cases where marked for run, then pull all test cases from that project and create the reports for each of them
    if params[:commit] == "Run"
      if params[:test_cases]
        params[:test_cases].each do |id|
          test_case = TestCase.find_by(_id: id, project_id: @project._id)

          report = Report.create(
            test_case_id: test_case.id,
            result: "NR", 
            comment: "", 
            test_run_id: @test_run._id)
        end
      end
    else
      test_cases = TestCase.where(project_id: @project._id)
      test_cases.each do |test_case|
        Report.create(
          test_case: test_case._id, 
          result: "NR", 
          comment: "", 
          test_run_id: @test_run._id)
      end
    end


    respond_to do |format|
      if @test_run.reports.length > 0
        @test_run.save
        format.html { redirect_to project_test_run_test_run_path(
          @project, 
          @test_run) }
      else
        format.html { redirect_to new_project_test_run_path(@project), 
          notice: 'No valid test case was given.', alert: 'danger' }
      end
    end
  end

  # DELETE /test_runs/1
  # DELETE /test_runs/1.json
  def destroy
    @test_run.destroy
    respond_to do |format|
      format.html { redirect_to project_test_runs_path(@project), 
        notice: 'Test run was successfully destroyed.', alert: 'success' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_run
      if params[:id]
        @test_run = TestRun.find(params[:id])
      else
        @test_run = TestRun.find(params[:test_run_id])
      end
    end

    def set_test_cases
      @tc_select = TestCase.list(params[:project_id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
