require 'rails_helper'

RSpec.describe "test_cases/index", type: :view do
  before(:each) do
    assign(:test_cases, [
      TestCase.create!(
        :identifier => "",
        :title => "",
        :steps => "",
        :preconditions => "",
        :postconditions => "",
        :use_cases => "",
        :requirements => ""
      ),
      TestCase.create!(
        :identifier => "",
        :title => "",
        :steps => "",
        :preconditions => "",
        :postconditions => "",
        :use_cases => "",
        :requirements => ""
      )
    ])
  end

  it "renders a list of test_cases" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
