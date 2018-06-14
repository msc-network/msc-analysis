# frozen_string_literal: true

require 'sinatra'
require 'bundler'
require 'fileutils'

Bundler.require

%w[db lib models].each do |dir|
  $LOAD_PATH << File.expand_path('.', File.join(File.dirname(__FILE__), dir))
  require_relative File.join(dir, 'init')
end

## create temp dir if it does not exist
tempdir = 'tmp'
Dir.mkdir(File.join(File.dirname(__FILE__), tempdir)) unless Dir.glob(tempdir)

set :bind, '0.0.0.0'

get '/' do
  erb :base
end

post '/analyze' do
  return 'No File Selected' unless params[:file]
  AnalyzeSong.new(params)
end

get '/upload' do
  erb :upload
end

get '/songs' do
  @songs = DB[:songs]
  erb :songs
end

get '/songs/:id' do
  @song = DB[:songs][:id]
  erb :song
end

post '/song_key' do
  return 'No File Selected' unless params[:file]
  tempdir = 'tmp'
  filename = File.join(tempdir, params[:file][:filename])
  datafile = params[:file]
  FileUtils.cp(datafile[:tempfile], filename)
  @song_training = SongKey.new(filename)
  
  tempo = SongTempo.new(filename).tempo

  musical_key = @song_training.parse_key
  @song = Song.create(artist: params[:artist], title: params[:title], musical_key: musical_key[:key], tempo: tempo)
  @song
  erb :result
end
