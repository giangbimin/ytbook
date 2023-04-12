require 'rails_helper'
RSpec.describe "/video_sources", type: :request do
  let(:valid_attributes) {
    {video_url: "https://www.youtube.com/watch?v=abc123"}
  }

  let(:invalid_attributes) {
    {video_url: "https://www.aaaaa.com/watch?v=abc123"}
  }

  describe "GET /index" do
    it "renders a successful response" do
      VideoSource.create! valid_attributes
      get video_sources_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get share_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new VideoSource" do
        expect {
          post video_sources_url, params: { video_source: valid_attributes }
        }.to change(VideoSource, :count).by(1)
      end

      it "redirects to the created video_source" do
        post video_sources_url, params: { video_source: valid_attributes }
        expect(response).to redirect_to(video_sources_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new VideoSource" do
        expect {
          post video_sources_url, params: { video_source: invalid_attributes }
        }.to change(VideoSource, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post video_sources_url, params: { video_source: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end
end
