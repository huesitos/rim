require 'rails_helper'

RSpec.describe "requirements/edit", type: :view do
  before(:each) do
    @requirement = assign(:requirement, Requirement.create!(
      :title => "",
      :description => "",
      :identifier => "",
      :priority => ""
    ))
  end

  it "renders the edit requirement form" do
    render

    assert_select "form[action=?][method=?]", requirement_path(@requirement), "post" do

      assert_select "input#requirement_title[name=?]", "requirement[title]"

      assert_select "input#requirement_description[name=?]", "requirement[description]"

      assert_select "input#requirement_identifier[name=?]", "requirement[identifier]"

      assert_select "input#requirement_priority[name=?]", "requirement[priority]"
    end
  end
end
