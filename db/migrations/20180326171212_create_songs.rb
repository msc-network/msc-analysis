# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :songs do
      primary_key :id
      String  :artist
      String  :title
      String  :isrc
      String  :release

      String  :danceability
      String  :duration
      String  :energy
      String  :loudness
      String  :musical_key
      String  :tempo
      String  :time_signature
    end
  end
end
