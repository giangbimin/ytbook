require 'rails_helper'

RSpec.describe UserReaction, type: :model do
  let(:user) { create(:user, email: "test@example.com", password: "password") }
  let(:video_source) { create(:video_source) }
  let(:video) { create(:video, video_source_id: video_source.id) }

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:video_id) }
    it { should validate_presence_of(:reaction) }
  end

  describe 'associations' do
    it { should belong_to(:video) }
  end

  describe 'after_save' do
    it 'should refresh video reactions count' do
      reaction = UserReaction.create(user_id: user.id, video_id: video.id, reaction: :like)
      video.reload
      expect(video.likes_count).to eq(1)
      expect(video.dislikes_count).to eq(0)

      reaction.update(reaction: :dislike)
      video.reload
      expect(video.likes_count).to eq(0)
      expect(video.dislikes_count).to eq(1)
    end
  end

  describe 'after_destroy' do
    it 'should refresh video reactions count' do
      reaction = UserReaction.create(user_id: user.id, video_id: video.id, reaction: :like)
      video.reload
      expect(video.likes_count).to eq(1)
      expect(video.dislikes_count).to eq(0)

      UserReaction.last.destroy
      video.reload
      expect(video.likes_count).to eq(0)
      expect(video.dislikes_count).to eq(0)
    end
  end
end