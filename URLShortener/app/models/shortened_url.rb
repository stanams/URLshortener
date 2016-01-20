# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string
#  submitter_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base

  validates :short_url, :uniqueness => true, :presence => true

  belongs_to :submitter,
    :primary_key => :id,
    :foreign_key => :submitter_id,
    :class_name => 'User'

  has_many :visits,
    :primary_key => :id,
    :foreign_key => :shortened_url_id,
    :class_name => 'Visit'

  has_many :visitors,
    :through => :visits,
    :source => :user

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
