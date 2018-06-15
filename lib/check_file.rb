class CheckFile
  attr_accessor :exists, :md5, :file
  
  def initialize(file)
    @file = file
    check_md5
  end
  
  def check_md5
    read_file_md5 = FileMd5.new(@file)
    @md5 = read_file_md5.call
  end
  
  def file_exists?
    @exists = AudioFile.where(md5: @md5)
  end
end
