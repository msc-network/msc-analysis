# frozen_string_literal: true

# Analyze Songs...
class Analyzer
  # Use essentia instead..
  # Upload file, grab md5 hash, filename and length of file,
  # Query File Model if exists, if true then Query that files Song and return Song attributes * if filled out
  # Else run song analysis, and relate Song to File, then save and return Song attributes.
  # 

  TEMPDIR = 'tmp'

  attr_accessor :file_md5, :params, :song

  def initialize(params)
    @params = params
    @file = @params[:file]
    @song = {}
    temp_file params
    check_file
    # save_file_details
  end

  def analyze
  end

  def check_file
    checked_file = CheckFile.new @file
    if checked_file.file_exists?
      # return the files related song
      @song = checked_file.song
    else
      # analyse file and save file and song details.
    end
  end

  def save_file_details *opts
    AudioFile.create(filename: opts[:filename], md5: opts[:md5], file_length: opts[:file_length])
  end

  def extract_music_data
    `essentia_streaming_extractor_music "#{@file}" "#{temp/}"`
  end

  def temp_file params
    @filename = File.join(TEMPDIR, params[:file][:filename])
    @datafile = params[:file]
    FileUtils.cp(@datafile[:tempfile], @filename)
  end
end
