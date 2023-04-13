class VideoSourcesController < ApplicationController
  # before_action :authorized

  def new
    @video_source = VideoSource.new
  end

  def index
    @video_sources = VideoSource.all
  end

  def create
    @video_source = VideoSource.new(video_source_params)
    status = GenerateVideoService.new(@video_source).execute
    respond_to do |format|
      if status
        format.html { redirect_to videos_url, notice: "Video was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    def video_source_params
      params.require(:video_source).permit(:video_url)
    end
end
