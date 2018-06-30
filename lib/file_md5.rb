# frozen_string_literal: true

# Analyze Songs...
class FileMd5
  attr_accessor :md5, :file

  def initialize(file)
    @file = file
  end

  def call
    result = `essentia_streaming_md5 "#{@file}"`
    @md5 = result.split[-1]
  end
end
