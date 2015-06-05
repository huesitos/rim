require 'rails_helper'

RSpec.describe "requirements/show", type: :view do
  before(:each) do
    @requirement = assign(:requirement, Requirement.create!(
      :title => "",
      :description => "",
      :identifier => "",
      :priority => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
