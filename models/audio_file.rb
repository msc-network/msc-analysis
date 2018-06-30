# frozen_string_literal: true

# File model
class AudioFile < Sequel::Model
  many_to_one :song
end
