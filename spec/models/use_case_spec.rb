require 'rails_helper'

RSpec.describe UseCase, type: :model do
  it "creates a new use case" do
  	use_case = FactoryGirl.create(:use_case)

    # Everything was saved correctly
    expect(UseCase.find(use_case._id).title).to eq(use_case.title)
    expect(UseCase.find(use_case._id).preconditions).to eq(use_case.preconditions)
    expect(UseCase.find(use_case._id).steps).to eq(use_case.steps)
    expect(UseCase.find(use_case._id).postconditions).to eq(use_case.postconditions)
    expect(UseCase.find(use_case._id).priority).to eq(use_case.priority)
    expect(UseCase.find(use_case._id).identifier).to eq(use_case.identifier)
    expect(UseCase.find(use_case._id).description).to eq(use_case.description)
  	expect(UseCase.find(use_case._id).requirements).to eq(use_case.requirements)
  end

  it "has to have a title" do
  	no_title = FactoryGirl.build(:uc_no_title)

  	expect(no_title.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_title.errors.messages[:title])
  end

  it "has to have steps" do
  	no_steps = FactoryGirl.build(:uc_no_steps)

  	expect(no_steps.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_steps.errors.messages[:steps])
  end

  it "has to have a description" do
  	no_description = FactoryGirl.build(:uc_no_description)

  	expect(no_description.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_description.errors.messages[:description])
  end

  describe "Priority" do
	  it "has to have priority" do
	  	no_priority = FactoryGirl.build(:uc_no_priority)

	  	expect(no_priority.valid?).to eq(false)
	  	assert_includes no_priority.errors.messages[:priority], "can't be blank"
	  end

	  it "has a priority included in Low, Medium, High" do
	  	wrong_priority = FactoryGirl.build(:uc_wrong_priority)

	  	expect(wrong_priority.valid?).to eq(false)
	  	assert_includes wrong_priority.errors.messages[:priority], "is not included in the list"
	  end
  end

  describe "Identifier" do
	  it "has to have an identifier" do
	  	no_identifier = FactoryGirl.build(:uc_no_identifier)

	  	expect(no_identifier.valid?).to eq(false)
	  	assert_includes no_identifier.errors.messages[:identifier], "can't be blank"
	  end

	  it "has an identifier with the format TCXX" do 
	  	wrong_identifier = FactoryGirl.build(:uc_wrong_identifier)

	  	expect(wrong_identifier.valid?).to eq(false)
	  	assert_includes wrong_identifier.errors.messages[:identifier], "format UCXX"
	  end
  end

  it "belongs to a project" do
  	no_project = FactoryGirl.build(:uc_no_project)

  	expect(no_project.valid?).to eq(false)
  	assert_includes no_project.errors.messages[:project], "use cases must belong to a project"
  end
end
