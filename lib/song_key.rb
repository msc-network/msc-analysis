# frozen_string_literal: true

# Obtain the key of a song.
class SongKey
  # attr_accessor :training_data
  def initialize(file)
    @file = file
    @training_data = NOTES # from musical_notes_data.rb
    @attributes = ['Key']
    @song_data = song_data
    @result = {}
    train_model
  end

  def song_data
    @t1 = Time.now
    puts 'Loading Song Data...'
    `aubiopitch "#{@file}"`
  end

  def train_model
    puts 'Training Model...'
    @dtree = DecisionTree::ID3Tree.new(@attributes,
                                       @training_data,
                                       'A4',
                                       :continuous)
    @dtree.train
  end

  def parse_key
    puts 'Working out Key...'
    data_arr = []
    @song_data.split.each_slice(2) { |d| data_arr << d }
    # Assertain the average value for the note height (Frequency)
    total_of_notes = 0
    data_arr.each { |dp| total_of_notes += dp[1].to_f }
    average_note = total_of_notes / data_arr.length
    test = [average_note, 'A4']
    @t2 = Time.now
    @result[:duration] = (@t2 - @t1).to_s + 'seconds' 
    @result[:key] = @dtree.predict test
    @result[:song_data] = data_arr
    remove_file
    @result
  end

  def remove_file
    FileUtils.remove_file(@file)
  end
end
