# frozen_string_literal: true

# Analyze Songs...
class AnalyzeSong
  def initialize(file)
    @song_key = SongKey.new file
    @song_tempo = SongTempo.new file
  end

  def tempo
  	@song_tempo.tempo
  end
end
