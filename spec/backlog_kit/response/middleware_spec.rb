describe BacklogKit::Response::Middleware do
  describe '.new' do
    let(:middleware) { described_class.new }

    subject { middleware }

    it { is_expected.to respond_to(:headers) }
    it { is_expected.not_to respond_to(:headers=) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.not_to respond_to(:status=) }
    it { is_expected.to respond_to(:body) }
    it { is_expected.not_to respond_to(:body=) }

    describe '#on_complete' do
      let(:env_mock) { instance_double('env') }
      let(:attributes) do
        [
          { 'key1' => { 'key2' => 'value2' } },
          { 'key3' => { 'key4' => 'value4' } },
          'value5'
        ]
      end
      let(:env_headers) { attributes }
      let(:env_status) { 200 }
      let(:env_body) { attributes }

      before do
        allow(env_mock).to receive(:response_headers).and_return(env_headers)
        allow(env_mock).to receive(:status).and_return(env_status)
        allow(env_mock).to receive(:body).and_return(env_body)
        middleware.on_complete(env_mock)
      end

      describe '#headers' do
        subject { middleware.headers }
        it { is_expected.to eq env_headers }
      end

      describe '#status' do
        subject { middleware.status }
        it { is_expected.to eq env_status }
      end

      describe '#body' do
        subject { middleware.body }
        it { is_expected.to eq env_body }
      end
    end
  end
end
