require 'rails_helper'

RSpec.describe "test_runs/index", type: :view do
  before(:each) do
    assign(:test_runs, [
      TestRun.create!(
        :date => ""
      ),
      TestRun.create!(
        :date => ""
      )
    ])
  end

  it "renders a list of test_runs" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
