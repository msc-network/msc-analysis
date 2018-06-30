# frozen_string_literal: true

# Analyze Songs...
class Analyzer
  # Use essentia instead..
  # Upload file, grab md5 hash, filename and length of file,
  # Query File Model if exists, if true then Query that files Song and return Song attributes * if filled out
  # Else run song analysis, and relate Song to File, then save and return Song attributes.
  # 

  TEMPDIR = 'tmp'

  attr_accessor :file_md5, :params, :song, :file_params, :checked_file

  def initialize(params)
    @params = params
    @file = @params[:file]
    @file_params = {}
    @song = {}
    # temp_file params
    check_file
  end

  def analyze
  end

  def check_file
    @checked_file = CheckFile.new @file
    if @checked_file.file_exists?
      # return the files related song
      @song = @checked_file.file_record
    else
      # analyse file and save file and song details.
      song_id = 22
      write_file_record @file, song_id
    end
  end

  def write_file_record file, song_id
    open_file = open @file
    filename = File.basename @file
    @file_params = {
      song_id: song_id,
      md5: @checked_file.md5,
      filename: filename,
      file_length: open_file.size,
    }
    AudioFile.create(@file_params)
  end

  def extract_music_data
    `essentia_streaming_extractor_music "#{@file}" "#{temp}"`
  end

  def temp_file params
    @filename = File.join(TEMPDIR, params[:file][:filename])
    @datafile = params[:file]
    FileUtils.cp(@datafile[:tempfile], @filename)
  end
end
