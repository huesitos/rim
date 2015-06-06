require "rails_helper"

RSpec.describe TestRunsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_runs").to route_to("test_runs#index")
    end

    it "routes to #new" do
      expect(:get => "/test_runs/new").to route_to("test_runs#new")
    end

    it "routes to #show" do
      expect(:get => "/test_runs/1").to route_to("test_runs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_runs/1/edit").to route_to("test_runs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_runs").to route_to("test_runs#create")
    end

    it "routes to #update" do
      expect(:put => "/test_runs/1").to route_to("test_runs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_runs/1").to route_to("test_runs#destroy", :id => "1")
    end

  end
end
