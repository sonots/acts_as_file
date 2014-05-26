require_relative 'spec_helper'
require 'acts_as_file'

class Post
  def initialize(params)
    @name = params[:name]
  end
  attr_accessor :name
  def save; end
  def destroy; end
  def self.delete_all; end
end

class TestPost < Post
  include ActsAsFile
  def filename
    @filename ||= Tempfile.open(self.name) {|f| f.path }.tap {|name| File.unlink(name) }
  end
  acts_as_file :body => self.instance_method(:filename)
end

describe ActsAsFile do
  let(:subject) { TestPost.new(name: 'name') }
  after { TestPost.delete_all }
  after { File.unlink(subject.filename) if File.exist?(subject.filename) }

  context '#body=' do
    it { expect { subject.body = 'aaaa' }.not_to raise_error }
  end

  context '#body' do
    context 'get from instance variable' do
      before { subject.body = 'aaaa' }
      its(:body) { should == 'aaaa' }
    end

    context 'get from file' do
      before { subject.body = nil }
      before { File.write(subject.filename, 'aaaa') }
      its(:body) { should == 'aaaa' }
    end

    context 'seek' do
      before { File.write(subject.filename, 'abcd') }
      it { subject.body(1, 2).should == 'bc' }
    end

    context 'file does not exit' do
      before { File.unlink(subject.filename) if File.exist?(subject.filename) }
      it { subject.body.should be_nil }
      it { subject.body(1, 2).should be_nil }
    end
  end
  
  context '#save_with_file' do
    context 'save if body exists' do
      before { subject.body = 'aaaa' }
      before { subject.save }
      it { expect(File.read(subject.filename)).to eql('aaaa') }
    end

    context 'does not save if body does not exist' do
      before { subject.body = nil }
      before { subject.save }
      it { expect(File.exist?(subject.filename)).to be_false }
    end
  end

  context '#destroy_with_file' do
    context 'delete if file exists' do
      before { subject.save }
      before { subject.destroy }
      it { expect(File.exist?(subject.filename)).to be_false }
    end

    context 'fine even if file does not exist' do
      before { subject.destroy }
      it { expect(File.exist?(subject.filename)).to be_false }
    end
  end
end
