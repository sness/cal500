#!/usr/bin/ruby

require 'pp'

if ARGV[1] == nil
  abort("Usage: parse_cal500_ground_truth.rb cal500_ground_truth.txt stacked_binary.txt")
else
  ground_truth_file = File.open(ARGV[0],"r")
  predict_file = File.open(ARGV[1],"r")
end

#
# Get the data from the ground truth
#
ground_truth = []
begin
  ground_truth_file.each_line do |line|
    a = line.split
    b = a[0].split('-')
    c = { :artist => b[0], :song => b[1], :tag => a[1]}
    ground_truth << c
  end
rescue EOFError
  ground_truth_file.close
end

#
# Generate unique lists of artists, songs and tags
#
gt_artists = []
gt_songs = []
gt_tags = []
ground_truth.each do |n|
  gt_artists << n[:artist]
  gt_songs << n[:song]
  gt_tags << n[:tag]
end

gt_artists = gt_artists.sort.uniq
gt_songs = gt_songs.sort.uniq
gt_tags = gt_tags.sort.uniq

#
# Get the data from the prediction
#
predict = []
begin
  predict_file.each_line do |line|
    a = line.split
    b = a[0].split('-')
    c = { :artist => b[0], :song => b[1], :tag => a[1]}
    predict << c
  end
rescue EOFError
  predict_file.close
end

#
# Ask the user to choose a artist from the ground truth
#
artist_str = ""
gt_artists.each_index do |i|
  artist_str += "(#{i} #{gt_artists[i]})"
end
puts artist_str

puts "Enter the number of a artist you wish to retrieve"
artist_num = $stdin.gets.chomp.to_i
artist_name = gt_artists[artist_num]
puts "Searching for : #{artist_name}"

#
# Find all the tags that this artist has
#
gt_found_tags = []
ground_truth.each do |n|
  if n[:artist] == artist_name
    gt_found_tags << n[:tag]
  end
end

pred_found_tags = []
predict.each do |n|
  if n[:artist] == artist_name
    pred_found_tags << n[:tag]
  end
end

gt_found_tags.sort!
pred_found_tags.sort!

max_size = gt_found_tags.size > pred_found_tags.size ? gt_found_tags.size : pred_found_tags.size

printf("%50s\t%50s\n","Ground Truth","Predicted")
printf("%50s\t%50s\n","------------","---------")
(0..max_size).each do |i|
  printf("%50s\t%50s\n",gt_found_tags[i],pred_found_tags[i]);
end

