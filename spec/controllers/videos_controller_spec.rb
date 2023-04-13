require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "loads all videos" do
      video_source = FactoryBot.create(:video_source)
      video1 = FactoryBot.create(:video, video_source_id: video_source.id)
      video2 = FactoryBot.create(:video, video_source_id: video_source.id)
      get :index
      expect(assigns(:videos)).to match_array([video1, video2])
    end

    it "includes video sources" do
      video_source = FactoryBot.create(:video_source)
      video1 = FactoryBot.create(:video, video_source_id: video_source.id)
      get :index
      expect(assigns(:videos).first.video_source).to eq(video_source)
    end
  end
end