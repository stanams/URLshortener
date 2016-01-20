# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :email, :uniqueness => true, :presence => true

  has_many :submitted_urls,
    :primary_key => :id,
    :foreign_key => :submitter_id,
    :class_name => 'ShortenedUrl'

  has_many :visits,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => 'Visit'
end
