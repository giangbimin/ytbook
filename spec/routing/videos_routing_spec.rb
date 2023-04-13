require "rails_helper"

RSpec.describe VideosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/videos").to route_to("videos#index")
    end
  end
end
