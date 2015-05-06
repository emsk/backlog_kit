require 'spec_helper'

describe BacklogKit::ResourceFile do
  describe '.new' do
    let(:filename) { 'テストファイル.txt' }
    let(:content) { 'テスト内容' }
    let(:resource) { described_class.new(filename, content) }

    subject { resource }

    it { is_expected.to respond_to(:filename) }
    it { is_expected.to respond_to(:filename=) }
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:content=) }

    describe '#filename' do
      subject { resource.filename }
      it { is_expected.to eq filename }
    end

    describe '#content' do
      subject { resource.content }
      it { is_expected.to eq content }
    end
  end
end
