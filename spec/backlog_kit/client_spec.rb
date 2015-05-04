require 'spec_helper'

describe BacklogKit::Client do
  let(:space_id) { 'test-space-id' }
  let(:api_key) { 'test-api-key' }
  let(:client) { described_class.new(space_id: space_id, api_key: api_key) }

  describe '.new' do
    subject { client }
    it { is_expected.to be_a described_class }
  end

  describe '#space_id' do
    subject { client.space_id }

    context 'when @space_id is not nil' do
      it { is_expected.to eq space_id }
    end

    context 'when @space_id is nil' do
      let(:space_id_env) { 'test-space-id-env' }

      before do
        stub_const('ENV', { 'BACKLOG_SPACE_ID' => space_id_env })
        client.space_id = nil
      end

      it { is_expected.to eq space_id_env }
    end
  end

  describe '#api_key' do
    subject { client.api_key }

    context 'when @api_key is not nil' do
      it { is_expected.to eq api_key }
    end

    context 'when @api_key is nil' do
      let(:api_key_env) { 'test-api-key-env' }

      before do
        stub_const('ENV', { 'BACKLOG_API_KEY' => api_key_env })
        client.api_key = nil
      end

      it { is_expected.to eq api_key_env }
    end
  end
end
