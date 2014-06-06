require_relative 'spec_helper'
require_relative 'model'

describe ActsAsFile do
  let(:subject) { TestPost.new }
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
      it { expect(subject.body(1, 2)).to be == 'bc' }
    end

    context 'file does not exit' do
      before { File.unlink(subject.filename) if File.exist?(subject.filename) }
      it { expect(subject.body).to be_nil }
      it { expect(subject.body(1, 2)).to be_nil }
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
      it { expect(File.exist?(subject.filename)).to be_falsey }
    end
  end

  context '#destroy_with_file' do
    context 'delete if file exists' do
      before { subject.save }
      before { subject.destroy }
      it { expect(File.exist?(subject.filename)).to be_falsey }
    end

    context 'fine even if file does not exist' do
      before { subject.destroy }
      it { expect(File.exist?(subject.filename)).to be_falsey }
    end
  end
end

