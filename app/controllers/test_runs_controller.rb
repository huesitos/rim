class TestRunsController < ApplicationController
  before_action :set_test_run, except: [:create, :new, :index]
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

  # GET /test_run/:id/run_test/:identifier
  # Retrieves a report of a test_case that hasn't been ran and runs it.
  # If all test_cases have been ran, then it redirects to the test_run result page, which is the show page
  def run_test
    reports = @test_run.reports.where(result: "NR")
    if reports.count > 0
      @test_case = TestCase.find(resports[0].test_case[:_id])
    else
      respond_to do |format|
        format.html { redirect_to project_test_run_path(@project, @test_run), notice: 'Test run finished successfully.' }
      end
    end
  end

  # PATCH /test_run/:id/run_test/:identifier/:result
  # Sets the result of the test_run on the test_case :identifier
  # If it was a failed run, then its redirected to create the issues
  def result
    report = @test_run.reports.find_by(identifier: params[:identifier])
    report.update(result: paramas[:result])

    respond_to do |format|
      if report.result == "Failed"
        format.html { #issues path
           }
      else
        format.html { redirect_to #run_test path
        }
      end
    end
  end

  # GET /test_run/:id/run_test/:identifier/issues
  def new_issues
  end

  # POST /test_run/:id/run_test/:identifier/issues
  def create_issues
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
