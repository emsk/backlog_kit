require 'spec_helper'

describe BacklogKit::Resource do
  describe '.new' do
    let(:value3) { '値3' }
    let(:value4) { %w(値4_1 値4_2) }
    let(:resource) do
      described_class.new(
        'key1' => { 'key2' => nil },
        'camelizedKey3' => value3,
        'key4' => value4
      )
    end

    subject { resource }

    it { is_expected.to be_a described_class }
    it { is_expected.to respond_to(:key1) }
    it { is_expected.to respond_to(:key1=) }
    it { is_expected.to respond_to(:key1?) }
    it { is_expected.to respond_to(:camelizedKey3) }
    it { is_expected.to respond_to(:camelizedKey3=) }
    it { is_expected.to respond_to(:camelizedKey3?) }
    it { is_expected.to respond_to(:camelized_key3) }
    it { is_expected.to respond_to(:camelized_key3=) }
    it { is_expected.to respond_to(:camelized_key3?) }
    it { is_expected.to respond_to(:key4) }
    it { is_expected.to respond_to(:key4=) }
    it { is_expected.to respond_to(:key4?) }

    describe '#key1' do
      subject { resource.key1 }

      it { is_expected.to be_a described_class }
      it { is_expected.to respond_to(:key2) }
      it { is_expected.to respond_to(:key2=) }
      it { is_expected.to respond_to(:key2?) }

      describe '#key2' do
        subject { resource.key1.key2 }
        it { is_expected.to be_nil }
      end

      describe '#key2=' do
        let(:new_value) { '新しい値2' }

        before do
          resource.key1.key2 = new_value
        end

        subject { resource.key1.key2 }
        it { is_expected.to eq new_value }
      end

      describe '#key2?' do
        subject { resource.key1.key2? }
        it { is_expected.to be_falsey }
      end
    end

    describe '#key1=' do
      let(:new_value) { '新しい値1' }

      before do
        resource.key1 = new_value
      end

      subject { resource.key1 }
      it { is_expected.to eq new_value }
    end

    describe '#key1?' do
      subject { resource.key1? }
      it { is_expected.to be_truthy }
    end

    describe '#camelizedKey3' do
      subject { resource.camelizedKey3 }
      it { is_expected.to eq value3 }
    end

    describe '#camelizedKey3=' do
      let(:new_value) { '新しい値3' }

      before do
        resource.camelizedKey3 = new_value
      end

      subject { resource.camelizedKey3 }
      it { is_expected.to eq new_value }
    end

    describe '#camelizedKey3?' do
      subject { resource.camelizedKey3? }
      it { is_expected.to be_truthy }
    end

    describe '#camelized_key3' do
      subject { resource.camelized_key3 }
      it { is_expected.to eq value3 }
    end

    describe '#camelized_key3=' do
      let(:new_value) { '新しい値3' }

      before do
        resource.camelized_key3 = new_value
      end

      subject { resource.camelized_key3 }
      it { is_expected.to eq new_value }
    end

    describe '#camelized_key3?' do
      subject { resource.camelized_key3? }
      it { is_expected.to be_truthy }
    end

    describe '#key4' do
      subject { resource.key4 }
      it { is_expected.to match_array value4 }
    end

    describe '#key4=' do
      let(:new_value) { '新しい値4' }

      before do
        resource.key4 = new_value
      end

      subject { resource.key4 }
      it { is_expected.to eq new_value }
    end

    describe '#key4?' do
      subject { resource.key4? }
      it { is_expected.to be_truthy }
    end
  end
end
