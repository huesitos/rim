class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /requirements
  # GET /requirements.json
  def index
    @requirements = Requirement.where(project_id: @project._id)
  end

  # GET /requirements/1
  # GET /requirements/1.json
  def show
    @related_use_cases = Requirement.related_use_cases(@requirement.identifier)
    @related_test_cases = Requirement.related_test_cases(@requirement.identifier)
  end

  # GET /requirements/new
  def new
    @errors = params[:errors]
    @requirement = Requirement.new
  end

  # GET /requirements/1/edit
  def edit
  end

  # POST /requirements
  # POST /requirements.json
  def create
    @requirement = Requirement.new(requirement_params)

    # Link to project
    @requirement.project = @project

    # Set identifier
    @requirement.identifier = Requirement.get_next_identifier(@requirement.kind)

    puts @requirement.identifier
    puts @requirement.kind

    respond_to do |format|
      if @requirement.save
        format.html { redirect_to project_requirement_path(@project, @requirement), notice: 'Requirement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /requirements/1
  # PATCH/PUT /requirements/1.json
  def update
    respond_to do |format|
      if @requirement.update(requirement_params)
        format.html { redirect_to project_requirement_path(@project, @requirement), notice: 'Requirement was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to project_requirements_path(@project), notice: 'Requirement was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params
      params.require(:requirement).permit(:title, :description, :priority, :kind)
    end
end
