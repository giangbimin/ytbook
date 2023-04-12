require 'rails_helper'

RSpec.describe VideoSourcesController, type: :controller do
  let(:valid_attributes) {
    {video_url: "https://www.youtube.com/watch?v=abc123"}
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

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns all video sources as @video_sources" do
      video_source = VideoSource.create!(valid_attributes)
      get :index
      expect(assigns(:video_sources)).to eq([video_source])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new VideoSource" do
        expect {
          post :create, params: { video_source: valid_attributes }
        }.to change(VideoSource, :count).by(1)
      end

      it "redirects to the video sources index" do
        post :create, params: { video_source: valid_attributes }
        expect(response).to redirect_to(video_sources_url)
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