require "rails_helper"

RSpec.describe Api::V1::RoomsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/rooms").to route_to("rooms#index")
    end

    it "routes to #show" do
      expect(:get => "/rooms/1").to route_to("rooms#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rooms").to route_to("rooms#create")
    end

  end
end
