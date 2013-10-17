# == Schema Information
# Schema version: 20090512221956
#
# Table name: tracks
#
#  id         :integer(4)      not null, primary key
#  song       :string(255)
#  artist     :string(255)
#  filename   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base

   has_many :track_tags
   has_many :tags, :through => :track_tags
   has_many :gt_tags, :through => :track_tags, :source => :tag, :conditions => "prediction_id = 1", :order => 'name'
   has_many :pred_tags, :through => :track_tags, :source => :tag, :conditions => "prediction_id = 2", :order => 'name'

end
