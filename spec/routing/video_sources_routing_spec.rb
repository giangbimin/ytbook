require "rails_helper"

RSpec.describe VideoSourcesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/video_sources").to route_to("video_sources#index")
    end

    it "routes to #new" do
      expect(get: "/video_sources/new").to route_to("video_sources#new")
    end

    it "routes to #show" do
      expect(get: "/video_sources/1").to route_to("video_sources#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/video_sources/1/edit").to route_to("video_sources#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/video_sources").to route_to("video_sources#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/video_sources/1").to route_to("video_sources#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/video_sources/1").to route_to("video_sources#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/video_sources/1").to route_to("video_sources#destroy", id: "1")
    end
  end
end
