# frozen_string_literal: true

# Song model
class Song < Sequel::Model
  one_to_one :audio_file
end
