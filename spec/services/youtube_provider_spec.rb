require 'rails_helper'

RSpec.describe YoutubeProvider, type: :service do
  describe '#call' do
    let(:video_id) { 'video_id' }
    let(:video_title) { 'video_title' }
    let(:video_description) { 'video_description' }
    let(:youtube_api_key) { 'youtube_api_key' }

    before do
      allow(ENV).to receive(:[]).with('YOUTUBE_API_KEY').and_return(youtube_api_key)
    end

    context 'with a blank video ID' do
      let(:response_body) do
        {
          items: [
            {
              snippet: {
                title: video_title,
                description: video_description
              }
            }
          ]
        }.to_json
      end

      before do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{youtube_api_key}&part=snippet").
          to_return(status: 200, body: response_body, headers: {})
      end

      it 'returns a hash with the error' do
        result = described_class.new(nil).call
        expect(result).to eq({error: 'Please input video ID'})
      end
    end


    context 'with a valid video ID' do
      let(:response_body) do
        {
          items: [
            {
              snippet: {
                title: video_title,
                description: video_description
              }
            }
          ]
        }.to_json
      end

      before do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{youtube_api_key}&part=snippet").
          to_return(status: 200, body: response_body, headers: {})
      end

      it 'returns a hash with the video info' do
        result = described_class.new(video_id).call
        expect(result).to eq({
          video_id: video_id,
          title: video_title,
          description: video_description
        })
      end
    end

    context 'with an invalid video ID' do
      let(:response_body) do
        {
          error: {
            message: 'Video not found'
          }
        }.to_json
      end

      before do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{youtube_api_key}&part=snippet").
          to_return(status: 404, body: response_body, headers: {})
      end

      it 'returns a hash with the error' do
        result = described_class.new(video_id).call
        expect(result).to eq({ error:'Video not found'})
      end
    end
  end
end