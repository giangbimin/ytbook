class VideoSourcesController < ApplicationController
  def new
    @video_source = VideoSource.new
  end

  def index
    @video_sources = VideoSource.all
  end

  def create
    @video_source = VideoSource.new(video_source_params)
    respond_to do |format|
      if @video_source.save
        format.html { redirect_to video_sources_url, notice: "Video source was successfully created." }
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
