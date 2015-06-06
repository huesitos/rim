require 'rails_helper'

RSpec.describe "test_runs/show", type: :view do
  before(:each) do
    @test_run = assign(:test_run, TestRun.create!(
      :date => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
