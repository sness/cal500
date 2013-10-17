# == Schema Information
# Schema version: 20090512221956
#
# Table name: track_tags
#
#  id            :integer(4)      not null, primary key
#  track_id      :integer(4)
#  tag_id        :integer(4)
#  prediction_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class TrackTag < ActiveRecord::Base

   belongs_to :track
   belongs_to :tag
   belongs_to :prediction

end
