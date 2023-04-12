require 'rails_helper'
require 'uri'
require 'net/http'
require 'json'

RSpec.describe YoutubeService do
  describe '#call' do
    context 'when given a valid YouTube URL' do
      let(:valid_url) { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }
      let(:video_id) { 'dQw4w9WgXcQ' }
      let(:video_info) { { 'title' => 'Rick Astley - Never Gonna Give You Up (Video)', 'description' => 'Rick Astley - Never Gonna Give You Up (Official Music Video) - Listen On Spotify: http://smarturl.it/AstleySpotify Download Rick\'s Number 1 album "50" - ht...' } }

      before do
        allow(ENV).to receive(:[]).with('YOUTUBE_API_KEY').and_return('fake_key')
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=fake_key&part=snippet")
          .to_return(status: 200, body: { 'items' => [{ 'snippet' => video_info }] }.to_json, headers: {})
      end

      it 'returns the video information' do
        expect(described_class.new(valid_url).call).to eq({ video_id: video_id, title: video_info['title'], description: video_info['description'] })
      end
    end

    context 'when given an invalid YouTube URL' do
      let(:invalid_url) { 'https://www.youtube.com/results?search_query=example' }

      it 'raises an ArgumentError' do
        expect { described_class.new(invalid_url).call }.to raise_error(ArgumentError, 'Invalid YouTube URL')
      end
    end

    context 'when there is an error with the API request' do
      let(:valid_url) { 'https://www.youtube.com/watch?v=dQw4w9WgXcQ' }
      let(:video_id) { 'dQw4w9WgXcQ' }

      before do
        allow(ENV).to receive(:[]).with('YOUTUBE_API_KEY').and_return('fake_key')
        stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=fake_key&part=snippet")
          .to_return(status: 404, body: '', headers: {})
      end

      it 'raises an error' do
        expect { described_class.new(valid_url).call }.to raise_error(JSON::ParserError)
      end
    end
  end
end
