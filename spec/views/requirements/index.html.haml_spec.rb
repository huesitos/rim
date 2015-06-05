require 'rails_helper'

RSpec.describe "requirements/index", type: :view do
  before(:each) do
    assign(:requirements, [
      Requirement.create!(
        :title => "",
        :description => "",
        :identifier => "",
        :priority => ""
      ),
      Requirement.create!(
        :title => "",
        :description => "",
        :identifier => "",
        :priority => ""
      )
    ])
  end

  it "renders a list of requirements" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
