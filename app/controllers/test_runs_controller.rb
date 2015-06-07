class TestRunsController < ApplicationController
  before_action :set_test_run, only: [:show, :update, :destroy]
  before_action :set_project

  # GET /test_runs
  # GET /test_runs.json
  def index
    @test_runs = TestRun.all
  end

  # GET /new
  def new
    @test_cases = TestCase.all
    @test_run = TestRun.new()
  end

  # GET /test_runs/1
  # GET /test_runs/1.json
  def show
  end

  # POST /test_runs
  # POST /test_runs.json
  def create
    @test_run = TestRun.new(date: Date.today)
    @test_run.summary = Summary.new(passed: 0, skiped: 0, failed: 0, total: 0)

    # If specific test cases where listed, then create a test run with a report object for each of the test cases
    # If all test cases where marked for run, then pull all test cases from that project and create the reports
    if params[:commit] == "Run"
      test_cases = params[:test_cases].split(',')
      puts "Test cases #{test_cases}"

      test_cases.each do |tc|
        if test_case = TestCase.find_by(identifier: tc)
          Report.create(test_case: {identifier: test_case.identifier, _id: test_case._id}, result: "NR", issues: [], comment: "", test_run_id: @test_run._id)
        end
      end
    else
      test_cases = TestCase.where(project_id: @project._id)
      test_cases.each do |tc|
        Report.create(test_case: {identifier: test_case.identifier, _id: test_case._id}, result: "NR", issues: [], comment: "", test_run_id: @test_run._id)
      end
    end

    @test_run.save

    respond_to do |format|
      if @test_run.reports.length > 0
        format.html { redirect_to project_test_runs_path(@project), notice: 'Test run was successfully created.' }
      else
        format.html { redirect_to project_test_runs_path(@project), notice: 'Test run was not created, no valid test_case was given.' }
      end
    end
  end

  # DELETE /test_runs/1
  # DELETE /test_runs/1.json
  def destroy
    @test_run.destroy
    respond_to do |format|
      format.html { redirect_to project_test_runs_path(@project), notice: 'Test run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_run
      @test_run = TestRun.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end
end
