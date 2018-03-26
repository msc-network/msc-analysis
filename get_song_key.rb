# frozen_string_literal: true

t1 = Time.now
# Quick and dirty script to determine the key of a given song
require 'decisiontree'
require_relative 'lib/musicical_notes_data'

# File name can go here or directly into aubiopitch path
# @file_name = '01 - Opening Sequence - Outside (Raining).mp3'
@file_name = ARGV[0] || 'demo_files/02 - Antikue - Into Jomsom.wav'
# @file_name = '03 - Antikue - Wind Hook (Demo v.3.wav'

puts 'Loading file...'
# Load raw data from Aubio Pitch
data = `aubiopitch "#{@file_name}"`
arr = []

# Group results in to sets of 2 ([Sample Time, Pitch at that Point])
data.split.each_slice(2) { |d| arr << d }

attributes = ['Key']
# load musical notes data for training
training = NOTES

puts 'Training model...'
# Build decision tree and train the model on musical notes
dec_tree = DecisionTree::ID3Tree.new(attributes, training, 'A4', :continuous)
dec_tree.train

# Assertain the average value for the note height (Frequency)
total_of_notes = 0
arr.each do |dp|
  total_of_notes += dp[1].to_f
end

average_note = total_of_notes / arr.length

test = [average_note, 'A4']

puts 'Your songs key is...'
puts dec_tree.predict test

t2 = Time.now

delta = t2 - t1

puts '--------------------'
puts 'This operation took ' + delta.to_s + ' seconds'
