class TestRunsController < ApplicationController
  before_action :set_test_run, except: [:create, :new, :index]
  before_action :set_project

  # GET /test_runs
  # GET /test_runs.json
  def index
    @test_runs = TestRun.where(project_id: @project._id)
  end

  # GET /new
  def new
    @test_cases = TestCase.where(project_id: @project._id)
    @test_run = TestRun.new()
  end

  # GET /test_runs/1
  # GET /test_runs/1.json
  def show
  end

  # GET /test_run/:id/run_test/:identifier
  # Retrieves next test case to run.
  # If there are no more test cases to run, it redirects to the
  # test_run show page to display the result of the test run
  def test_run
    identifier = TestRun.next_test(@test_run)

    respond_to do |format|
      if identifier
        format.html { redirect_to project_test_run_run_test_path(
          @project, 
          @test_run, 
          identifier: identifier)}
      else
        format.html { redirect_to project_test_run_path(@project, @test_run), 
            notice: 'Test run finished successfully.' }
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
    report = TestRun.get_report(@test_run, params[:identifier])
    report.update(result: params[:commit], comment: params[:comment])

    if params[:commit] == "Pass"
      @test_run.summary.inc(passed: 1)
    elsif params[:commit] == "Skip"
      @test_run.summary.inc(skipped: 1)
    else
      @test_run.summary.inc(failed: 1)
    end
    @test_run.summary.save

    redirect_to project_test_run_test_run_path(@project, @test_run)
  end

  # POST /test_runs
  # POST /test_runs.json
  def create
    @test_run = TestRun.new(date: DateTime.now)
    @test_run.summary = Summary.new(
      passed: 0, 
      skipped: 0, 
      failed: 0, 
      total: 0)

    # If specific test cases where listed, then create a test run with a report object for each of the test cases
    # If all test cases where marked for run, then pull all test cases from that project and create the reports for each of them
    if params[:commit] == "Run"
      test_cases = params[:test_cases].split(',')
      puts "Test cases #{test_cases}"

      test_cases.each do |identifier|
        if test_case = TestCase.find_by(identifier: identifier, project_id: @project._id)
          Report.create(
            test_case: {identifier: test_case.identifier, _id: test_case._id}, 
            result: "NR", 
            comment: "", 
            test_run_id: @test_run._id)
        end
      end
    else
      test_cases = TestCase.where(project_id: @project._id)
      test_cases.each do |test_case|
        Report.create(
          test_case: {identifier: test_case.identifier, _id: test_case._id}, 
          result: "NR", 
          comment: "", 
          test_run_id: @test_run._id)
      end
    end

    @test_run.save

    respond_to do |format|
      if @test_run.reports.length > 0
        format.html { redirect_to project_test_run_test_run_path(
          @project, 
          @test_run) }
      else
        format.html { redirect_to project_test_runs_path(@project), 
          notice: 'Test run was not created, no valid test_case was given.' }
      end
    end
  end

  # DELETE /test_runs/1
  # DELETE /test_runs/1.json
  def destroy
    @test_run.destroy
    respond_to do |format|
      format.html { redirect_to project_test_runs_path(@project), 
        notice: 'Test run was successfully destroyed.' }
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

    def set_project
      @project = Project.find(params[:project_id])
    end
end
