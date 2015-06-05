require 'rails_helper'

RSpec.describe UseCase, type: :model do
  it "creates a new use case" do
  	use_case = FactoryGirl.create(:use_case)

  	expect(UseCase.find(use_case._id).title).to eq(use_case.title)
  end

  it "has to have title" do
  	no_title = FactoryGirl.build(:no_title)

  	expect(no_title.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_title.errors.messages[:title])
  end

  it "has to have steps" do
  	no_steps = FactoryGirl.build(:no_steps)

  	expect(no_steps.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_steps.errors.messages[:steps])
  end

  it "has to have description" do
  	no_description = FactoryGirl.build(:no_description)

  	expect(no_description.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_description.errors.messages[:description])
  end

  describe "Priority" do
	  it "has to have priority" do
	  	no_priority = FactoryGirl.build(:no_priority)

	  	expect(no_priority.valid?).to eq(false)
	  	assert_includes no_priority.errors.messages[:priority], "can't be blank"
	  end

	  it "has a priority included in Low, Medium, High" do
	  	wrong_priority = FactoryGirl.build(:wrong_priority)

	  	expect(wrong_priority.valid?).to eq(false)
	  	assert_includes wrong_priority.errors.messages[:priority], "is not included in the list"
	  end
  end

  describe "Identifier" do
	  it "has to have an identifier" do
	  	no_identifier = FactoryGirl.build(:no_identifier)

	  	expect(no_identifier.valid?).to eq(false)
	  	assert_includes no_identifier.errors.messages[:identifier], "can't be blank"
	  end

	  it "has an identifier with the format" do 
	  	wrong_identifier = FactoryGirl.build(:wrong_identifier)

	  	expect(wrong_identifier.valid?).to eq(false)
	  	assert_includes wrong_identifier.errors.messages[:identifier], "format CUXX"
	  end
  end

  it "belongs to a project" do
  	no_project = FactoryGirl.build(:no_project)

  	expect(no_project.valid?).to eq(false)
  	assert_includes no_project.errors.messages[:project], "use cases have to belong to a project"
  end
end
