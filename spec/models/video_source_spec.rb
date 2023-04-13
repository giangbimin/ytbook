require 'rails_helper'

RSpec.describe VideoSource, type: :model do
  describe "validations" do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:identify_id) }
    it { should allow_value("https://www.youtube.com/watch?v=abc123").for(:video_url) }
    it { should allow_value("https://youtu.be/abc123").for(:video_url) }
    it { should_not allow_value("").for(:video_url).with_message('blank') }
  end

  describe "parse_url" do
    it "sets provider to youtube when given a valid YouTube URL" do
      video_source = VideoSource.new(video_url: "https://www.youtube.com/watch?v=abc123")
      video_source.valid?
      expect(video_source.provider).to eq(:youtube.to_s)
    end

    it "sets identify_id to the YouTube video ID when given a valid YouTube URL" do
      video_source = VideoSource.new(video_url: "https://www.youtube.com/watch?v=abc123")
      video_source.valid?
      expect(video_source.identify_id).to eq("abc123")
    end

    it "raises an error when given a URL with an invalid format" do
      video_source = VideoSource.new(video_url: "com/abc123")
      video_source.valid?
      expect(video_source.errors[:video_url]).to include("invalid format")
    end

    it "sets errors when given a URL with an unsupported provider" do
      video_source = VideoSource.new(video_url: "https://vimeo.com/abc123")
      video_source.valid?
      expect(video_source.errors[:provider]).to include("unsupported provider")
    end

    it "sets errors when the URL is blank" do
      video_source = VideoSource.new(video_url: "")
      video_source.valid?
      expect(video_source.errors[:video_url]).to include("blank")
    end
  end
end
