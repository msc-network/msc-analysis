# frozen_string_literal: true

# Obtain the tempo of a song.
class SongTempo
	attr_accessor :tempo, :tempo_float

	def initialize(file)
		@file = file
		@tempo = song_tempo.chop
		@tempo_float = @tempo.to_f
	end

  def song_tempo
  	puts 'Estimating song tempo...'
    `aubio tempo "#{@file}"`
  end
end
