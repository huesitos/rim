require 'rails_helper'

RSpec.describe "test_runs/new", type: :view do
  before(:each) do
    assign(:test_run, TestRun.new(
      :date => ""
    ))
  end

  it "renders new test_run form" do
    render

    assert_select "form[action=?][method=?]", test_runs_path, "post" do

      assert_select "input#test_run_date[name=?]", "test_run[date]"
    end
  end
end
