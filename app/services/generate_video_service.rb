class GenerateVideoService
  attr_accessor :user_id

  def initialize video_source
    @video_source = video_source
  end

  def execute
    status = false
    return status unless @video_source.valid?
    video_information = video_information_from_provider
    return false if video_information.present? && video_information[:error].present?
    ActiveRecord::Base.transaction do
      @video_source.save!
      video_attrs = {
        title: video_information[:title],
        description: video_information[:description],
        video_source_id: @video_source.id,
        user_id: user_id
      }
      Video.create!(video_attrs)
      status = true
    end
    status
  end

  def video_information_from_provider
    YoutubeProvider.new(@video_source.identify_id).call
  end
end