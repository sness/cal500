# == Schema Information
# Schema version: 20090512221956
#
# Table name: predictions
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  params     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Prediction < ActiveRecord::Base

  has_many :tags, :through => :track_tags

end
