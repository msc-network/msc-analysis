# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :audio_files do
      primary_key :id
      foreign_key :song_id, :songs
      String :filename
      String :md5
      Integer :file_length
    end
  end
end
