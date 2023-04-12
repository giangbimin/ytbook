require 'uri'
require 'net/http'
require 'json'


class YoutubeProvider
  def initialize(video_id)
    @video_id = video_id
  end

  def call
    raise ArgumentError.new('Invalid video ID ') if @video_id.blank?
    items = video_items
    raise ArgumentError.new('Invalid video ID ') if items.blank?
    video = items[0]['snippet']
    {
      video_id: @video_id,
      title: video['title'],
      description: video['description']
    }
  end

  private

  def video_items
    @video_info ||= begin
      url = "https://www.googleapis.com/youtube/v3/videos?id=#{@video_id}&key=#{ENV['YOUTUBE_API_KEY']}&part=snippet"
      response = Net::HTTP.get(URI(url))
      JSON.parse(response)['items']
    end
  end
end
