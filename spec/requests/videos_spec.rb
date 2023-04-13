require 'rails_helper'

RSpec.describe "/videos", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      video_source = VideoSource.create!(provider: :youtube, identify_id: "asdasdas")
      Video.create!(video_source_id: video_source.id, title: "title", description: "description")
      get videos_url
      expect(response).to be_successful
    end
  end
end
