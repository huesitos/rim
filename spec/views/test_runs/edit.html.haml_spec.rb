require 'rails_helper'

RSpec.describe "test_runs/edit", type: :view do
  before(:each) do
    @test_run = assign(:test_run, TestRun.create!(
      :date => ""
    ))
  end

  it "renders the edit test_run form" do
    render

    assert_select "form[action=?][method=?]", test_run_path(@test_run), "post" do

      assert_select "input#test_run_date[name=?]", "test_run[date]"
    end
  end
end
