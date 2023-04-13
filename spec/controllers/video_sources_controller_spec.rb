require 'rails_helper'

RSpec.describe VideoSourcesController, type: :controller do
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

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns a new video source as @video_source" do
      get :new
      expect(assigns(:video_source)).to be_a_new(VideoSource)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before do
        allow_any_instance_of(YoutubeProvider).to receive(:call).and_return(valid_provider_res)
      end
      it "creates a new Video" do
        expect {
          post :create, params: { video_source: valid_attributes }
        }.to change(Video, :count).by(1)
      end

      it "redirects to the videos index" do
        post :create, params: { video_source: valid_attributes }
        expect(response).to redirect_to(videos_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved video source as @video_source" do
        post :create, params: { video_source: invalid_attributes }
        expect(assigns(:video_source)).to be_a_new(VideoSource)
      end

      it "re-renders the new template" do
        post :create, params: { video_source: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end