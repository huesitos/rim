require 'rails_helper'

RSpec.describe Requirement, type: :model do
  it "creates a new requirement" do
  	requirement = FactoryGirl.create(:requirement)

    # Everything was saved correctly
    expect(Requirement.find(requirement._id).title).to eq(requirement.title)
    expect(Requirement.find(requirement._id).priority).to eq(requirement.priority)
    expect(Requirement.find(requirement._id).identifier).to eq(requirement.identifier)
    expect(Requirement.find(requirement._id).description).to eq(requirement.description)
  	expect(Requirement.find(requirement._id).kind).to eq(requirement.kind)
  end

  it "has to have a description" do
  	no_description = FactoryGirl.build(:rq_no_description)

  	expect(no_description.valid?).to eq(false)
  	expect(["can't be blank"]).to eq(no_description.errors.messages[:description])
  end

  describe "Priority" do
	  it "has to have priority" do
	  	no_priority = FactoryGirl.build(:rq_no_priority)

	  	expect(no_priority.valid?).to eq(false)
	  	assert_includes no_priority.errors.messages[:priority], "can't be blank"
	  end

	  it "has a priority included in Low, Medium, High" do
	  	wrong_priority = FactoryGirl.build(:rq_wrong_priority)

	  	expect(wrong_priority.valid?).to eq(false)
	  	assert_includes wrong_priority.errors.messages[:priority], "is not included in the list"
	  end
  end

  describe "Identifier" do
	  it "has to have an identifier" do
	  	no_identifier = FactoryGirl.build(:rq_no_identifier)

	  	expect(no_identifier.valid?).to eq(false)
	  	assert_includes no_identifier.errors.messages[:identifier], "can't be blank"
	  end

	  it "has an identifier with the format (F|NF)RXX" do 
	  	wrong_identifier = FactoryGirl.build(:rq_wrong_identifier)

	  	expect(wrong_identifier.valid?).to eq(false)
	  	assert_includes wrong_identifier.errors.messages[:identifier], "format (F|NF)RXX"
	  end
  end

  describe "Kind" do
	  it "has to have a kind" do
	  	no_kind = FactoryGirl.build(:rq_no_kind)

	  	expect(no_kind.valid?).to eq(false)
	  	assert_includes no_kind.errors.messages[:kind], "can't be blank"
	  end

	  it "has a kind included in Functional, Non-Functional" do 
	  	wrong_kind = FactoryGirl.build(:rq_wrong_kind)

	  	expect(wrong_kind.valid?).to eq(false)
	  	assert_includes wrong_kind.errors.messages[:kind], "is not included in the list"
	  end
  end

  it "belongs to a project" do
  	no_project = FactoryGirl.build(:rq_no_project)

  	expect(no_project.valid?).to eq(false)
  	assert_includes no_project.errors.messages[:project], "requirements must belong to a project"
  end
end
