class CreateTrackTags < ActiveRecord::Migration
  def self.up
    create_table :track_tags do |t|
      t.integer :track_id
      t.integer :tag_id
      t.integer :prediction_id

      t.timestamps
    end
  end

  def self.down
    drop_table :track_tags
  end
end
