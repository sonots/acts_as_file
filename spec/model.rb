require 'acts_as_file'

class TestPost
  include ActsAsFile
  def filename
    @filename ||= Tempfile.open('test_acts_as_file') {|f| f.path }.tap {|name| File.unlink(name) }
  end
  acts_as_file :body => self.instance_method(:filename)
end
