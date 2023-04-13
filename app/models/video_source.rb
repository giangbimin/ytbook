class VideoSource < ApplicationRecord
  PROVIDER_DOMAINS = {'www.youtube.com' => :youtube, 'youtube.com' => :youtube, 'youtu.be' => :youtube}
  enum provider: { youtube: 1 }
  validates :provider, presence: true
  validates :identify_id, presence: true
  attr_accessor :video_url
  before_validation :parse_url, on: :create

  private

  def parse_url
    return if provider.present? && identify_id.present?
    return errors.add(:video_url, 'blank') if video_url.blank?
    uri = URI.parse(video_url)
    return errors.add(:video_url, 'invalid format') unless uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
    self.provider = PROVIDER_DOMAINS[uri.host]
    errors.add(:provider, 'unsupported provider') if self.provider.blank?
    self.identify_id = identify_id_by_uri(uri)
  end

  def identify_id_by_uri uri
    return unless self.youtube?
    Rack::Utils.parse_query(uri.query)['v'] || uri.path.split('/').reject(&:blank?).last 
  end
end
