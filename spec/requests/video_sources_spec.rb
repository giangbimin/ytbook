require 'rails_helper'
RSpec.describe "/video_sources", type: :request do
  let(:video_id) {'dQw4w9WgXcQ'}
  let(:valid_provider_res) {{
    video_id: video_id,
    title: 'Rick Astley - Never Gonna Give You Up (Video)',
    description: 'Rick Astley - Never Gonna Give You Up (Official Music Video) - Listen On Spotify: http://smarturl.it/AstleySpotify\nLearn more about the brand new album ‘Beautiful ...'
  }}
  let(:valid_attributes) {
    {video_url: "https://www.youtube.com/watch?v=#{video_id}"}
  }
  let(:invalid_attributes) {
    {video_url: "https://www.aaaaa.com/watch?v=abc123"}
  }

  describe "GET /new" do
    it "renders a successful response" do
      get share_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      before do
        allow_any_instance_of(YoutubeProvider).to receive(:call).and_return(valid_provider_res)
      end
      it "creates a new VideoSource" do
        expect {
          post video_sources_url, params: { video_source: valid_attributes }
        }.to change(Video, :count).by(1)
      end

      it "redirects to the videos list" do
        post video_sources_url, params: { video_source: valid_attributes }
        expect(response).to redirect_to(videos_url)
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
