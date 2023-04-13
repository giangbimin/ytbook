class VideosController < ApplicationController
  def index
    @videos = Video.all.includes(:video_source).order(created_at: :desc)
  end
end
