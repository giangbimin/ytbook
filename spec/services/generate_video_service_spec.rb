require 'rails_helper'

RSpec.describe GenerateVideoService, type: :service do
  let(:video_id) {'dQw4w9WgXcQ'}
  let(:valid_provider_res) {{
    video_id: video_id,
    title: 'Rick Astley - Never Gonna Give You Up (Video)',
    description: 'Rick Astley - Never Gonna Give You Up (Official Music Video) - Listen On Spotify: http://smarturl.it/AstleySpotify\nLearn more about the brand new album ‘Beautiful ...'
  }}
  let(:invalid_provider_res) {{error: 'Video not found'}}
  let(:video_source) { VideoSource.new(provider: :youtube, identify_id: video_id) }
  let(:generate_video_service) { GenerateVideoService.new(video_source) }

  describe "#execute" do
    context "when video source is invalid" do
      before do
        video_source.identify_id = nil
      end

      it "should not create a new video" do
        expect {
          generate_video_service.execute
        }.not_to change(Video, :count)
      end

      it "should return false" do
        expect(generate_video_service.execute).to eq(false)
      end
    end

    context "when video source is valid and video information is successfully generated" do
      before do
        allow_any_instance_of(YoutubeProvider).to receive(:call).and_return(valid_provider_res)
      end
  
      it "should create a new video" do
        expect {
          generate_video_service.execute
        }.to change(Video, :count).by(1)
      end

      it "should return true" do
        expect(generate_video_service.execute).to eq(true)
      end
    end

    context "when video source is valid and video information is invalid" do
      before do
        allow_any_instance_of(YoutubeProvider).to receive(:call).and_return(invalid_provider_res)
        video_source.video_url = "invalid_url"
      end

      it "should not create a new video" do
        expect {
          generate_video_service.execute
        }.not_to change(Video, :count)
      end

      it "should return false" do
        expect(generate_video_service.execute).to eq(false)
      end
    end
  end
end