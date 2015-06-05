require 'rails_helper'

RSpec.describe "requirements/new", type: :view do
  before(:each) do
    assign(:requirement, Requirement.new(
      :title => "",
      :description => "",
      :identifier => "",
      :priority => ""
    ))
  end

  it "renders new requirement form" do
    render

    assert_select "form[action=?][method=?]", requirements_path, "post" do

      assert_select "input#requirement_title[name=?]", "requirement[title]"

      assert_select "input#requirement_description[name=?]", "requirement[description]"

      assert_select "input#requirement_identifier[name=?]", "requirement[identifier]"

      assert_select "input#requirement_priority[name=?]", "requirement[priority]"
    end
  end
end
