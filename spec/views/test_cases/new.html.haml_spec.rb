require 'rails_helper'

RSpec.describe "test_cases/new", type: :view do
  before(:each) do
    assign(:test_case, TestCase.new(
      :identifier => "",
      :title => "",
      :steps => "",
      :preconditions => "",
      :postconditions => "",
      :use_cases => "",
      :requirements => ""
    ))
  end

  it "renders new test_case form" do
    render

    assert_select "form[action=?][method=?]", test_cases_path, "post" do

      assert_select "input#test_case_identifier[name=?]", "test_case[identifier]"

      assert_select "input#test_case_title[name=?]", "test_case[title]"

      assert_select "input#test_case_steps[name=?]", "test_case[steps]"

      assert_select "input#test_case_preconditions[name=?]", "test_case[preconditions]"

      assert_select "input#test_case_postconditions[name=?]", "test_case[postconditions]"

      assert_select "input#test_case_use_cases[name=?]", "test_case[use_cases]"

      assert_select "input#test_case_requirements[name=?]", "test_case[requirements]"
    end
  end
end
