require 'spec_helper'

describe BacklogKit::Response do
  describe '.new' do
    let(:faraday_response_mock) { instance_double('faraday response') }
    let(:attributes) do
      [
        { 'key1' => { 'key2' => 'value2' } },
        { 'key3' => { 'key4' => 'value4' } },
        'value5'
      ]
    end
    let(:faraday_headers) { attributes }
    let(:faraday_status) { 200 }
    let(:faraday_body) { attributes }
    let(:response) { described_class.new(faraday_response_mock) }

    before do
      allow(faraday_response_mock).to receive(:headers).and_return(faraday_headers)
      allow(faraday_response_mock).to receive(:status).and_return(faraday_status)
      allow(faraday_response_mock).to receive(:body).and_return(faraday_body)
    end

    describe 'BacklogKit::Resource' do
      after do
        response
      end

      subject { BacklogKit::Resource }
      it { is_expected.to receive(:new).exactly(6).times }
    end

    describe '#headers' do
      subject { response.headers }
      it { is_expected.to be_a Array }

      describe '#size' do
        subject { response.headers.size }
        it { is_expected.to eq 3 }
      end

      describe '#[0]' do
        subject { response.headers[0] }
        it { is_expected.to be_a BacklogKit::Resource }
      end
    end

    describe '#status' do
      subject { response.status }
      it { is_expected.to eq faraday_status }
    end

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#size' do
        subject { response.body.size }
        it { is_expected.to eq 3 }
      end

      describe '#[0]' do
        subject { response.body[0] }
        it { is_expected.to be_a BacklogKit::Resource }
      end
    end
  end
end
