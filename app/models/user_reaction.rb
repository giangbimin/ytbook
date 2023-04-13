class UserReaction < ApplicationRecord
  validates :user_id, :video_id, presence: true
  validates :reaction, presence: true
  enum reaction: {like: 0, dislike: 1}

  belongs_to :video

  after_save :refresh_video_meta_information
  after_destroy :refresh_video_meta_information

  private

  def refresh_video_meta_information
    video.refresh_reactions_count
  end
end
