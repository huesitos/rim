class TestCasesController < ApplicationController
  before_action :set_test_case, only: [:show, :edit, :update, :destroy]
  before_action :set_requirements_list, except: [:show, :destroy]
  before_action :set_use_cases_list, except: [:show, :destroy]
  before_action :set_requirements, only: [:edit, :update]
  before_action :set_use_cases, only: [:edit, :update]
  before_action :set_project
  before_action :require_user

  # GET /test_cases
  # GET /test_cases.json
  def index
    query = {project_id: @project._id}
    if params[:requirements] then query[:requirement_ids] = { "$in" => params[:requirements]} end
    if params[:use_cases] then query[:use_case_ids] = { "$in" => params[:use_cases]} end

    @test_cases = TestCase.where(query)
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

      @test_case = TestCase.new(
        title: use_case[:title],
        description: use_case[:description], 
        steps: use_case[:steps], 
        preconditions: use_case[:preconditions], 
        postconditions: use_case[:postconditions])
      @use_cases = [use_case.id]
      @requirements = use_case.requirements.pluck(:_id)
    else
      @test_case = TestCase.new
    end
  end

  # GET /test_cases/1/edit
  def edit
    
  end

  # POST /test_cases
  # POST /test_cases.json
  def create
    @test_case = TestCase.new(
      title: test_case_params[:title], 
      steps: test_case_params[:steps], 
      preconditions: test_case_params[:preconditions], 
      postconditions: test_case_params[:postconditions], 
      description: test_case_params[:description],
      user_id: @project.user.id)

    # Set identifier
    @test_case.identifier = TestCase.get_next_identifier(@project._id)

    # Link to project
    @test_case.project = @project

    # Set use cases array
    @test_case.use_cases << UseCase.where(
      :_id.in => params[:use_cases]) if params[:use_cases]

    # Set requirements of use cases
    @test_case.use_cases.each do |uc|
      @test_case.requirements << uc.requirements
    end
    
    # Requirements
    @test_case.requirements << Requirement.where(
      :_id.in => params[:requirements]) if params[:requirements]

    respond_to do |format|
      if @test_case.save
        if params[:commit] == "Continue"
          format.html { redirect_to new_project_test_case_path(@project) }
        else
          format.html { redirect_to project_test_cases_path(@project), 
            notice: 'Test case was successfully created.', alert: 'success' }
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /test_cases/1
  # PATCH/PUT /test_cases/1.json
  def update
    respond_to do |format|
      if @test_case.update(
        title: test_case_params[:title], 
        steps: test_case_params[:steps], 
        preconditions: test_case_params[:preconditions], 
        postconditions: test_case_params[:postconditions], 
        description: test_case_params[:description])

        @test_case.use_cases = UseCase.where(:_id.in => params[:use_cases])
        @test_case.requirements = Requirement.where(:_id.in => params[:requirements])
        
        # Set requirements of use cases
        @test_case.use_cases.each do |uc|
          @test_case.requirements << uc.requirements
        end

        format.html { redirect_to project_test_case_path(@project, @test_case), 
          notice: 'Test case was successfully updated.', alert: 'success' }
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
      format.html { redirect_to project_test_cases_path(@project), 
        notice: 'Test case was successfully destroyed.', alert: 'success' }
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

    # Set list of all requirements for form
    def set_requirements_list
      @requirements_list = Requirement.list(params[:project_id])
    end

    # Set list of all use cases for form
    def set_use_cases_list
      @use_cases_list = UseCase.list(params[:project_id])
    end

    # Set list of all test_case's requirements
    def set_requirements
      @requirements = TestCase.find(params[:id]).req_list
    end

    # Set list of all test_case's use cases
    def set_use_cases
      @use_cases = TestCase.find(params[:id]).uc_list
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_case_params
      params.require(:test_case).permit(:title, :description, :steps, :preconditions, :postconditions)
    end
end
