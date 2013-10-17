# == Schema Information
# Schema version: 20090512221956
#
# Table name: tags
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base

   has_many :tracks, :through => :track_tags
   has_many :predictions, :through => :track_tags

end
