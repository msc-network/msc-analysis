This is a spec for Audio Analysis via API.

Software that can be of use:

sox - http://sox.soucforge.net
ffmpeg
aubio
ecasound


bit of ruby:

sort pitch data into an array

data = `aubiopitch "02\ -\ Antikue\ -\ Into\ Jomsom.wav"`
arr = []
data.split().each_slice(2) {|d| arr << d}

returns an array of each pitch & coresponding sample point into an array

# desicion tree

# frozen_string_literal: true
require 'decisiontree'

attributes = ['Key']
training = musical_notes_data.rb

dec_tree = DecisionTree::ID3Tree.new(attributes, training, 'A4', :continuous)
dec_tree.train

ar = 0
arr.each do |dp|
  ar += dp[1].to_f
end
test = [ar, 'A4']
puts dec_tree.predict test
