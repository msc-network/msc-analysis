# frozen_string_literal: true

# Analyze Songs...
class AnalyzeSong
  # Use essentia instead..
  # Upload file, grab md5 hash, filename and length of file,
  # Query File Model if exists, if true then Query that files Song and return Song attributes * if filled out
  # Else run song analysis, and relate Song to File, then save and return Song attributes.
  # 

  TEMPDIR = 'tmp'

  attr_accessor :file_md5, :params

  def initialize(params)
    @params = params
    @file = @params[:file]
    @song = {}
    temp_file params
    file_md5
    save_file_details
  end

  def analyze
  end

  def file_md5
    read_file = FileMd5.new(@file)
    @file_md5 = read_file.call
  end

  def find_audio_file
    @audio_file = AudioFile.where(md5: @file_md5)
  end

  def save_file_details
    return @audio_file unless find_audio_file
    AudioFile.create(filename: filename)
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
