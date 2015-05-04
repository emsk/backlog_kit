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

  shared_examples_for 'a normal http client' do
    before do
      stub_api_request
    end

    subject { response }

    it 'makes a request' do
      subject
      expect(stub_api_request).to have_been_requested
    end

    it { is_expected.to be_a BacklogKit::Response }

    describe '#headers' do
      subject { response.headers }
      it { is_expected.to be_a BacklogKit::Resource }
    end

    describe '#status' do
      subject { response.status }
      it { is_expected.to eq response_status }
    end

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a BacklogKit::Resource }
    end
  end

  let(:request_params) do
    {
      abcdEfgh_1234_ijklMnop: 'テスト',
      abcdEfgh_5678_ijklMnop: 'テスト',
      abcdEfgh_1234: 'テスト',
      '1234_abcdEfgh_1234' => { abcdEfgh_9012_ijklMnop: 'テスト' }
    }
  end

  let(:request_path) { 'test' }

  let(:underscored_request_params) do
    {
      abcd_efgh_1234_ijkl_mnop: 'テスト',
      abcdEfgh_5678_ijklMnop: 'テスト',
      abcdEfgh_1234: 'テスト',
      '1234_abcdEfgh_1234' => { abcd_efgh_9012_ijkl_mnop: 'テスト' }
    }
  end

  describe '#get' do
    let(:request_method) { :get }
    let(:camelized_request_params) { { query: request_params } }
    let(:response_status) { 200 }
    let(:response) { client.get(request_path, underscored_request_params) }

    it_behaves_like 'a normal http client'
  end

  describe '#post' do
    let(:request_method) { :post }
    let(:camelized_request_params) { { body: request_params } }
    let(:response_status) { 201 }
    let(:response) { client.post(request_path, underscored_request_params) }

    it_behaves_like 'a normal http client'
  end

  describe '#put' do
    let(:request_method) { :put }
    let(:camelized_request_params) { { body: request_params } }
    let(:response_status) { 200 }
    let(:response) { client.put(request_path, underscored_request_params) }

    it_behaves_like 'a normal http client'
  end

  describe '#patch' do
    let(:request_method) { :patch }
    let(:camelized_request_params) { { body: request_params } }
    let(:response_status) { 200 }
    let(:response) { client.patch(request_path, underscored_request_params) }

    it_behaves_like 'a normal http client'
  end

  describe '#delete' do
    let(:request_method) { :delete }
    let(:camelized_request_params) { { query: request_params } }
    let(:response_status) { 200 }
    let(:response) { client.delete(request_path, underscored_request_params) }

    it_behaves_like 'a normal http client'
  end

  def stub_api_request
    stub_request(request_method, "https://#{space_id}.backlog.jp/api/v2/#{request_path}?apiKey=#{api_key}")
      .with({ headers: { 'User-Agent' => described_class::USER_AGENT } }.merge(camelized_request_params))
      .to_return(
        headers: { 'Content-Type' => 'application/json; charset=utf-8' },
        status: response_status,
        body: { 'test' => 'test' }.to_json
      )
  end
end
