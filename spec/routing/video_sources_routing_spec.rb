require "rails_helper"

RSpec.describe VideoSourcesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/share").to route_to("video_sources#new")
    end

    it "routes to #create" do
      expect(post: "/video_sources").to route_to("video_sources#create")
    end
  end
end
