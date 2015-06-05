require 'rails_helper'

RSpec.describe UseCase, type: :model do
  it "creates a new use case" do
  	use_case = FactoryGirl.create(:use_case)

  	expect(UseCase.find(use_case._id).title).to eq(use_case.title)
  end

  it "has to have title, steps, priority, description, and identifier" do
  end

  it "has an identifier with the format" do
  end

  it "has a priority included in Low, Medium, High" do
  end
end
