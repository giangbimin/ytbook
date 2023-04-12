require 'uri'
require 'net/http'
require 'json'

class YoutubeService
  YOUTUBE_API_KEY = "AIzaSyC21gBTvwwHYjzE1OUKd3TR9raGKUL1mY0"

  def initialize(url)
    @url = url
  end

  def call
r    raise ArgumentError.new('Invalid YouTube URL') unless valid_url?
    {
      video_id: video_id,
      title: video_info['title'],
      description: video_info['description']
    }
  end

  private

  def valid_url?
    uri = URI.parse(@url)
    uri.host =~ /youtube\.com$/ && uri.path == '/watch' && !video_id.nil?
  rescue URI::InvalidURIError
    false
  end

  def video_id
    @video_id ||= URI.parse(@url).query.split('&').find { |p| p.start_with?('v=') }&.gsub('v=', '')
  end

  def video_info
    @video_info ||= begin
      url = "https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{YOUTUBE_API_KEY}&part=snippet"
      response = Net::HTTP.get(URI(url))
      JSON.parse(response)['items'][0]['snippet']
    end
  end
end
