# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  shortened_url_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ActiveRecord::Base

  validates :shortened_url_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :user,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => 'User'

  belongs_to :shortened_url,
    :primary_key => :id,
    :foreign_key => :shortened_url_id,
    :class_name => 'ShortenedUrl'
end
