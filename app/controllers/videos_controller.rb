class VideosController < ApplicationController
  def index
    @videos = Video.all.includes(:video_source)
  end
end
