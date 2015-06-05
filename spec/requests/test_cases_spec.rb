require 'rails_helper'

RSpec.describe "TestCases", type: :request do
  describe "GET /test_cases" do
    it "works! (now write some real specs)" do
      get test_cases_path
      expect(response).to have_http_status(200)
    end
  end
end
