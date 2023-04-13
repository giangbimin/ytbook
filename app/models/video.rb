class Video < ApplicationRecord
  belongs_to :video_source
  validates :title, :video_source_id, presence: true
end
