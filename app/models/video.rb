class Video < ApplicationRecord
  validates :title, :video_source_id, presence: true

  belongs_to :video_source
  belongs_to :user, optional: true
  has_many :user_reactions

  delegate :identify_id, to: :video_source, prefix: false
  delegate :email, to: :user, prefix: true, allow_nil: true

  def refresh_reactions_count
    reaction_count = user_reactions.group(:reaction).count
    attrs = {
      likes_count: reaction_count['like'].to_i,
      dislikes_count: reaction_count['dislike'].to_i
    }
    self.update_columns(attrs)
  end
end
