class UseCasesController < ApplicationController
  before_action :set_use_case, only: [:show, :edit, :update, :destroy]
  before_action :set_requirements_list, except: [:show, :destroy]
  before_action :set_requirements, only: [:edit, :update]
  before_action :set_priorities, except: [:show, :destroy]
  before_action :set_priority, only: [:edit, :update]
  before_action :set_project
  before_action :require_user

  # GET /use_cases
  # GET /use_cases.json
  def index
    query = {project_id: @project._id}
    if params[:priority] 
      if params[:priority] != "All"
        query[:priority] = params[:priority]
      end
    end
    if params[:requirements] then query[:requirement_ids] = { "$in" => params[:requirements]} end
    
    @use_cases = UseCase.where(query)
  end

  # GET /use_cases/1
  # GET /use_cases/1.json
  def show
    @related_test_cases = UseCase.related_test_cases(
      @use_case.identifier,
      @project._id)
  end

  # GET /use_cases/new
  def new
    @use_case = UseCase.new
    @new = true
  end

  # GET /use_cases/1/edit
  def edit
    @priority = @use_case.priority.id

    @requirements = []
    @use_case.requirements.each do |r|
      @requirements << r.id
    end
  end

  # POST /use_cases
  # POST /use_cases.json
  def create
    @use_case = UseCase.new(
      title: use_case_params[:title], 
      preconditions: use_case_params[:preconditions], 
      postconditions: use_case_params[:postconditions], 
      steps: use_case_params[:steps], 
      description: use_case_params[:description],
      user_id: @project.user.id)

    # Add priority
    @use_case.priority = Priority.find(use_case_params[:priority])

    # Add identifier
    @use_case.identifier = UseCase.get_next_identifier(@project._id)

    # Link to project
    @use_case.project = @project

    # Requirements
    @use_case.requirements << Requirement.where(:_id.in => params[:requirements]) if params[:requirements]

    respond_to do |format|
      if @use_case.save
        if params[:commit] == "Continue"
          format.html { redirect_to new_project_use_case_path(@project) }
        else
          # If the use case was saved correctly, create a default new test case form to create a new test case immediately
          format.html { redirect_to project_use_cases_path(@project), notice: 'Use case was successfully created.', alert: 'success' }
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /use_cases/1
  # PATCH/PUT /use_cases/1.json
  def update
    respond_to do |format|
      @use_case.priority = Priority.find(use_case_params[:priority])
      
      if @use_case.save
        if @use_case.update(title: use_case_params[:title], 
          preconditions: use_case_params[:preconditions], 
          postconditions: use_case_params[:postconditions], 
          steps: use_case_params[:steps], 
          description: use_case_params[:description])

          @use_case.requirements = Requirement.where(:_id.in => params[:requirements])

          format.html { redirect_to project_use_case_path(@project, @use_case), 
            notice: 'Use case was successfully updated.', alert: 'success' }
        else
          format.html { render :edit }
        end
      end
    end
  end

  # DELETE /use_cases/1
  # DELETE /use_cases/1.json
  def destroy
    @use_case.destroy
    respond_to do |format|
      format.html { redirect_to project_use_cases_path(@project), 
        notice: 'Use case was successfully destroyed.', alert: 'success' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_use_case
      @use_case = UseCase.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Set list of all requirements for form
    def set_requirements_list
      @requirements_list = Requirement.list(params[:project_id])
    end

    # Set list of all use_case's requirements
    def set_requirements
      @requirements = UseCase.find(params[:id]).req_list
    end

    # Set list priorities
    def set_priorities
      @priorities = Priority.all.pluck(:name, :_id)
    end

    # Set use_case's both priority and kind
    def set_priority
      @priority = UseCase.find(params[:id]).priority.name
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:title, :description, :preconditions, :steps, :postconditions, :priority)
    end
end
