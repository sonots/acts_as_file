require 'acts_as_file'

class TestPost
  def initialize(params)
    @name = params[:name]
  end
  attr_accessor :name

  include ActsAsFile
  def filename
    @filename ||= Tempfile.open(self.name) {|f| f.path }.tap {|name| File.unlink(name) }
  end
  acts_as_file :body => self.instance_method(:filename)
end
