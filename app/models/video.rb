class Video < ApplicationRecord
  belongs_to :video_source
  validates :title, :video_source_id, presence: true
  delegate :identify_id, to: :video_source, prefix: false
end
