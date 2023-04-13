FactoryBot.define do
  factory :user_reaction do
    user_id { 1 }
    video_id { 1 }
    reaction { 1 }
  end
end
