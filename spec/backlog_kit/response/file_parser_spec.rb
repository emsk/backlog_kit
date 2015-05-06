require 'spec_helper'

describe BacklogKit::Response::FileParser do
  let(:faraday_env) { Faraday::Env.new }
  let(:faraday_env_headers) do
    {
      'content-type' => 'image/png',
      'content-disposition' => "attachment; filename*=UTF-8''%E7%8C%AB.png"
    }
  end
  let(:faraday_env_status) { 200 }
  let(:faraday_env_body) { 'file content' }
  let(:response) { described_class.new(faraday_env) }

  before do
    allow(faraday_env).to receive(:response_headers).and_return(faraday_env_headers)
    allow(faraday_env).to receive(:status).and_return(faraday_env_status)
    faraday_env.body = faraday_env_body
  end

  context 'after #on_complete' do
    describe 'BacklogKit::Response::FileParser' do
      before do
        response.on_complete(faraday_env)
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
        context 'when status code is 204' do
          let(:faraday_env_status) { 204 }

          subject { response.body }
          it { is_expected.to eq faraday_env_body }
        end

        context 'when content type is not image' do
          let(:faraday_env_headers) { { 'content-type' => 'application/json; charset=utf-8' } }

          subject { response.body }
          it { is_expected.to eq faraday_env_body }
        end
      end
    end

    describe 'Faraday::Env' do
      describe '#body' do
        context 'when response is file' do
          before do
            allow(response).to receive(:file?).and_return(true)
            response.on_complete(faraday_env)
          end

          subject { faraday_env.body }
          it { is_expected.to be_a BacklogKit::ResourceFile }

          describe '#filename' do
            subject { faraday_env.body.filename }
            it { is_expected.to eq '猫.png' }
          end

          describe '#content' do
            subject { faraday_env.body.content }
            it { is_expected.to eq faraday_env_body }
          end
        end

        context 'when response is not file' do
          before do
            allow(response).to receive(:file?).and_return(false)
            response.on_complete(faraday_env)
          end

          subject { faraday_env.body }
          it { is_expected.to eq faraday_env_body }
        end
      end
    end
  end
end
