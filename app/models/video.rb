class Video < ApplicationRecord
  belongs_to :video_source
  belongs_to :user, optional: true
  validates :title, :video_source_id, presence: true
  delegate :identify_id, to: :video_source, prefix: false
  delegate :email, to: :user, prefix: true, allow_nil: true
end
