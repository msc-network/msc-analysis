# frozen_string_literal: true

DB = Sequel.connect 'sqlite://db/mscanalysis.sqlite3'

Dir.glob(File.expand_path(File.dirname(__FILE__)) + '/../models/*.{rb,class}') { |file| require file }
