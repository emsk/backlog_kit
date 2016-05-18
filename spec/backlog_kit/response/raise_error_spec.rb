require 'spec_helper'

describe BacklogKit::Response::RaiseError do
  let(:faraday_env_mock) { instance_double('faraday env') }
  let(:faraday_env_headers) { { 'content-type' => 'application/json; charset=utf-8' } }
  let(:faraday_env_status) { 200 }
  let(:error_code) { 1 }
  let(:faraday_env_body) do
    {
      'errors' => [
        { 'message' => 'エラー1', 'code' => error_code, 'moreInfo' => '' },
        { 'message' => 'エラー2', 'code' => error_code, 'moreInfo' => '' }
      ]
    }.to_json
  end
  let(:response) { described_class.new(faraday_env_mock) }

  before do
    allow(faraday_env_mock).to receive(:response_headers).and_return(faraday_env_headers)
    allow(faraday_env_mock).to receive(:status).and_return(faraday_env_status)
    allow(faraday_env_mock).to receive(:body).and_return(faraday_env_body)
  end

  describe '#on_complete' do
    subject { lambda { response.on_complete(faraday_env_mock) } }

    context 'when error code contains 1' do
      let(:error_code) { 1 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 2' do
      let(:error_code) { 2 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 3' do
      let(:error_code) { 3 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 4' do
      let(:error_code) { 4 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 5' do
      let(:error_code) { 5 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 6' do
      let(:error_code) { 6 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 7' do
      let(:error_code) { 7 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 8' do
      let(:error_code) { 8 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 9' do
      let(:error_code) { 9 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 10' do
      let(:error_code) { 10 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains 11' do
      let(:error_code) { 11 }
      it_behaves_like 'raise errors'
    end

    context 'when error code contains unexpected code' do
      let(:error_code) { 99 }
      it { is_expected.to raise_error(BacklogKit::Error, "[ERROR 1] UnexpectedError - エラー1 (CODE: #{error_code}), [ERROR 2] UnexpectedError - エラー2 (CODE: #{error_code})") }
    end

    context 'when status code is 204' do
      let(:faraday_env_status) { 204 }
      it { is_expected.not_to raise_error }
    end

    context 'when content type is not json' do
      let(:faraday_env_headers) { { 'content-type' => 'image/gif' } }
      it { is_expected.not_to raise_error }
    end

    context 'when json body is array' do
      let(:faraday_env_body) { [{ 'key1' => 'value1' }].to_json }
      it { is_expected.not_to raise_error }
    end

    context 'when json body does not contains error' do
      let(:faraday_env_body) { { 'key1' => 'value1' }.to_json }
      it { is_expected.not_to raise_error }
    end
  end

  context 'after #on_complete' do
    describe 'BacklogKit::Response::RaiseError' do
      before do
        allow(response).to receive(:success?).and_return(true)
        response.on_complete(faraday_env_mock)
      end

      describe '#headers' do
        subject { response.headers }
        it { is_expected.to eq faraday_env_headers }
      end

      describe '#status' do
        subject { response.status }
        it { is_expected.to eq faraday_env_status }
      end

      describe '#body' do
        subject { response.body }
        it { is_expected.to eq faraday_env_body }
      end
    end
  end
end
