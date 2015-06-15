class TestCasesController < ApplicationController
  before_action :set_test_case, only: [:show, :edit, :update, :destroy]
  before_action :set_requirements, only: [:new, :edit]
  before_action :set_use_cases, only: [:new, :edit]
  before_action :set_project

  # GET /test_cases
  # GET /test_cases.json
  def index
    @test_cases = TestCase.where(project_id: @project._id)
  end

  # GET /test_cases/1
  # GET /test_cases/1.json
  def show
  end

  # GET /test_cases/new
  def new
    # If there as a call from a use_case, then some default values will be set using that use_case's values
    # If not, then just make an empty TestCase
    if params[:use_case]
      use_case = UseCase.find(params[:use_case])
      
      requirements = []
      use_case.requirements.each do |rq|
        requirements << rq["identifier"]+','
      end

      @test_case = TestCase.new(
        title: use_case[:title], 
        steps: use_case[:steps], 
        preconditions: use_case[:preconditions], 
        postconditions: use_case[:postconditions], 
        use_cases: [use_case[:identifier]], 
        requirements: requirements)
    else
      @test_case = TestCase.new
    end
  end

  # GET /test_cases/1/edit
  def edit
    @requirements = []
    @test_case.requirements.each do |r|
      @requirements << r.id
    end

    @use_cases = []
    @test_case.use_cases.each do |ucr|
      @use_cases << uc.id
    end
  end

  # POST /test_cases
  # POST /test_cases.json
  def create
    @test_case = TestCase.new(
      title: test_case_params[:title], 
      steps: test_case_params[:steps], 
      preconditions: test_case_params[:preconditions], 
      postconditions: test_case_params[:postconditions], 
      description: test_case_params[:description])

    # Set identifier
    @test_case.identifier = TestCase.get_next_identifier(@project._id)

    # Link to project
    @test_case.project = @project

    # Set use cases array
    @test_case.use_cases << UseCase.where(:_id.in => params[:use_cases])
    
    # Requirements
    @test_case.requirements << Requirement.where(:_id.in => params[:requirements])

    respond_to do |format|
      if @test_case.save
        format.html { redirect_to project_test_case_path(@project, @test_case), notice: 'Test case was successfully created.', alert: 'success' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PATCH/PUT /test_cases/1
  # PATCH/PUT /test_cases/1.json
  def update
    use_cases_array = UseCase.set_use_cases( test_case_params[:use_cases])
    requirements_array = Requirement.set_requirements( test_case_params[:requirements])

    respond_to do |format|
      if @test_case.update(
        title: test_case_params[:title], 
        steps: test_case_params[:steps], 
        preconditions: test_case_params[:preconditions], 
        postconditions: test_case_params[:postconditions], 
        description: test_case_params[:description], 
        use_cases: use_cases_array, 
        requirements: requirements_array)
        format.html { redirect_to project_test_case_path(@project, @test_case), notice: 'Test case was successfully updated.', alert: 'sucess' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /test_cases/1
  # DELETE /test_cases/1.json
  def destroy
    @test_case.destroy
    respond_to do |format|
      format.html { redirect_to project_test_cases_path(@project), notice: 'Test case was successfully destroyed.', alert: 'success' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_case
      @test_case = TestCase.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_requirements
      @requirements_list = []

      Requirement.each do |r|
        @requirements_list << [r.identifier, r.id]
      end
    end

    def set_use_cases
      @use_cases_list = []

      UseCase.each do |uc|
        @use_cases_list << [uc.identifier, uc.id]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_params
      params.require(:test_case).permit(:title, :description, :steps, :preconditions, :postconditions, :use_cases, :requirements)
    end
end
