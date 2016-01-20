class ShortenedUrl < ActiveRecord::Base

  validates :short_url, :uniqueness => true, :presence => true

  def self.random_code
    short_url = SecureRandom.base64
    while ShortenedUrl.exists?(:short_url => short_url)
      short_url = SecureRandom.base64
    end
    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code

    ShortenedUrl.create!(:long_url => long_url,
                         :short_url => short_url,
                         :submitter_id => user.id)
  end
end
