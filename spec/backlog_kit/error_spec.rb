require 'spec_helper'

describe BacklogKit::Error do
  describe '.build_error_message' do
    let(:index) { 1 }
    let(:message) { 'エラーです。' }
    let(:code) { 99 }
    let(:basic_error_message) do
      "[ERROR #{index}] #{described_class.name.demodulize} - #{message} (CODE: #{code})"
    end

    subject { described_class.build_error_message(response, index) }

    context 'given no more info' do
      let(:response) { { 'message' => message, 'code' => code } }
      it { is_expected.to eq basic_error_message }
    end

    context 'given more info' do
      let(:more_info) { 'すごいエラー！' }
      let(:response) { { 'message' => message, 'code' => code, 'moreInfo' => more_info } }
      it { is_expected.to eq "#{basic_error_message} (MORE INFO: #{more_info})" }
    end
  end
end
