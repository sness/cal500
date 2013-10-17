#!/usr/bin/ruby

require 'pp'

if ARGV[0] == nil
  abort("Usage: parse_cal500_ground_truth.rb cal500_ground_truth.txt stacked_binary.txt")
else
  ground_truth_file = File.open(ARGV[0],"r")
  predict_file = File.open(ARGV[1],"r")
end

#
# Get the data from the ground
#
ground_truth = []
begin
  ground_truth_file.each_line do |line|
    a = line.split
    b = { :track => a[0], :tag => a[1]}
    ground_truth << b
  end
rescue EOFError
  ground_truth_file.close
end

#
# Generate lists of artists, songs and tags
#
gt_tracks = []
gt_tags = []
ground_truth.each do |n|
  gt_tracks << n[:track]
  gt_tags << n[:tag]
end

#
# Get the data from the prediction
#
predict = []
begin
  predict_file.each_line do |line|
    a = line.split
    b = { :track => a[0], :tag => a[1]}
    predict << b
  end
rescue EOFError
  predict_file.close
end

#
# Generate lists of artists, songs and tags
#
pred_tracks = []
pred_tags = []
ground_truth.each do |n|
  pred_tracks << n[:track]
  pred_tags << n[:tag]
end

#
# Merge both the ground truth and predictions into
#
tracks = (gt_tracks + pred_tracks).sort.uniq
tags = (gt_tags + pred_tags).sort.uniq

#
# Output the artists.yml file
#
File.open("tracks.yml","w") do |f|
  f.puts "---"
  tracks.each_index do |i|
    a = tracks[i].split("-")
    artist = a[0].gsub("_"," ").split(" ").collect! {|n| n.capitalize }.join(" ")
    song = a[1].gsub("_"," ").split(" ").collect! {|n| n.capitalize }.join(" ")
    f.puts "- !ruby/object:Track"
     f.puts "  attributes: "
     f.puts "    id: #{i+1}"
     f.puts "    artist: #{artist}"
     f.puts "    song: #{song}"
     f.puts "    filename: #{tracks[i]}"
  end
end

#
# Output the tags.yml file
#
File.open("tags.yml","w") do |f|
  f.puts "---"
  tags.each_index do |i|
    f.puts "- !ruby/object:Tag"
    f.puts "  attributes: "
    f.puts "    id: #{i+1}"
    f.puts "    name: #{tags[i]}"
  end
end

#
# Output the predictions.yml file
#
File.open("predictions.yml","w") do |f|
  f.puts "---"
  f.puts "- !ruby/object:Prediction"
  f.puts "  attributes: "
  f.puts "    id: 1"
  f.puts "    name: Ground Truth"
  f.puts "    params: "
  f.puts "- !ruby/object:Prediction"
  f.puts "  attributes: "
  f.puts "    id: 2"
  f.puts "    name: Stacked Annotation"
  f.puts "    params: "
end

#
# Output the song_tags.yml file
#
File.open("track_tags.yml","w") do |f|
  f.puts "---"
  i = 0
  ground_truth.each do |n|
    track_id = tracks.index(n[:track])
    tag_id = tags.index(n[:tag])
    f.puts "- !ruby/object:TrackTag"
    f.puts "  attributes: "
    f.puts "    id: #{i+1}"
    f.puts "    track_id: #{track_id + 1}"
    f.puts "    tag_id: #{tag_id + 1}"
    f.puts "    prediction_id: 1"
    i += 1
  end
  predict.each do |n|
    track_id = tracks.index(n[:track])
    tag_id = tags.index(n[:tag])
    f.puts "- !ruby/object:TrackTag"
    f.puts "  attributes: "
    f.puts "    id: #{i+1}"
    f.puts "    track_id: #{track_id + 1}"
    f.puts "    tag_id: #{tag_id + 1}"
    f.puts "    prediction_id: 2"
    i += 1
  end
end
