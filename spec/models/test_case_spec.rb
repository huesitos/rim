require 'rails_helper'

RSpec.describe TestCase, type: :model do
  it "creates a new test case" do
  	test_case = FactoryGirl.create(:test_case)

  	# Everything was saved correctly
  	expect(TestCase.find(test_case._id).title).to eq(test_case.title)
  	expect(TestCase.find(test_case._id).preconditions).to eq(test_case.preconditions)
    expect(TestCase.find(test_case._id).steps).to eq(test_case.steps)
    expect(TestCase.find(test_case._id).postconditions).to eq(test_case.postconditions)
    expect(TestCase.find(test_case._id).identifier).to eq(test_case.identifier)
    expect(TestCase.find(test_case._id).description).to eq(test_case.description)
  	expect(TestCase.find(test_case._id).requirements).to eq(test_case.requirements)
  end

  it "has to have a title" do
  	no_title = FactoryGirl.build(:tc_no_title)

  	expect(no_title.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_title.errors.messages[:title])
  end

  it "has to have steps" do
  	no_steps = FactoryGirl.build(:tc_no_steps)

  	expect(no_steps.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_steps.errors.messages[:steps])
  end

  it "has to have a description" do
  	no_description = FactoryGirl.build(:tc_no_description)

  	expect(no_description.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_description.errors.messages[:description])
  end

  describe "Identifier" do
	  it "has to have an identifier" do
	  	no_identifier = FactoryGirl.build(:tc_no_identifier)

	  	expect(no_identifier.valid?).to eq(false)
	  	assert_includes no_identifier.errors.messages[:identifier], "can't be blank"
	  end

	  it "has an identifier with the format TCXX" do 
	  	wrong_identifier = FactoryGirl.build(:tc_wrong_identifier)

	  	expect(wrong_identifier.valid?).to eq(false)
	  	assert_includes wrong_identifier.errors.messages[:identifier], "format TCXX"
	  end
  end

  it "belongs to a project" do
  	no_project = FactoryGirl.build(:tc_no_project)

  	expect(no_project.valid?).to eq(false)
  	assert_includes no_project.errors.messages[:project], "test cases have to belong to a project"
  end
end
