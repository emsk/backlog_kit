describe BacklogKit::Client do
  let(:space_id) { 'test-space-id' }
  let(:second_level_domain) { 'second-level-domain' }
  let(:top_level_domain) { 'top-level-domain' }
  let(:api_key) { 'test-api-key' }
  let(:client_id) { 'test-client-id' }
  let(:client) { described_class.new(space_id: space_id, api_key: api_key) }

  describe '.new' do
    subject { client }

    it { is_expected.to be_a described_class }
    it { is_expected.to respond_to(:space_id) }
    it { is_expected.to respond_to(:space_id=) }
    it { is_expected.to respond_to(:second_level_domain) }
    it { is_expected.to respond_to(:second_level_domain=) }
    it { is_expected.to respond_to(:top_level_domain) }
    it { is_expected.to respond_to(:top_level_domain=) }
    it { is_expected.to respond_to(:api_key) }
    it { is_expected.to respond_to(:api_key=) }
    it { is_expected.to respond_to(:client_id) }
    it { is_expected.to respond_to(:client_id=) }
    it { is_expected.to respond_to(:client_secret) }
    it { is_expected.to respond_to(:client_secret=) }
    it { is_expected.to respond_to(:refresh_token) }
    it { is_expected.to respond_to(:refresh_token=) }
    it { is_expected.to respond_to(:redirect_uri) }
    it { is_expected.to respond_to(:redirect_uri=) }
    it { is_expected.to respond_to(:state) }
    it { is_expected.to respond_to(:state=) }
    it { is_expected.to respond_to(:access_token) }
    it { is_expected.to respond_to(:access_token=) }
  end

  describe '#space_id' do
    subject { client.space_id }

    context 'when preset @space_id from args' do
      it { is_expected.to eq space_id }
    end

    context 'when preset @space_id from ENV' do
      let(:client) { described_class.new }
      let(:space_id_env) { 'test-space-id-env' }

      before do
        stub_const('ENV', { 'BACKLOG_SPACE_ID' => space_id_env })
      end

      it { is_expected.to eq space_id_env }
    end
  end

  describe '#second_level_domain' do
    subject { client.second_level_domain }

    context 'when not set @second_level_domain' do
      before do
        stub_const('ENV', { 'BACKLOG_SECOND_LEVEL_DOMAIN' => nil })
      end

      it { is_expected.to eq 'backlog' }
    end

    context 'when preset @second_level_domain from args' do
      let(:client) { described_class.new(second_level_domain: second_level_domain) }

      it { is_expected.to eq second_level_domain }
    end

    context 'when preset @second_level_domain from ENV' do
      let(:client) { described_class.new }
      let(:second_level_domain_env) { 'test-second-level-domain-env' }

      before do
        stub_const('ENV', { 'BACKLOG_SECOND_LEVEL_DOMAIN' => second_level_domain_env })
      end

      it { is_expected.to eq second_level_domain_env }
    end
  end

  describe '#top_level_domain' do
    subject { client.top_level_domain }

    context 'when not set @top_level_domain' do
      before do
        stub_const('ENV', { 'BACKLOG_TOP_LEVEL_DOMAIN' => nil })
      end

      it { is_expected.to eq 'jp' }
    end

    context 'when preset @top_level_domain from args' do
      let(:client) { described_class.new(top_level_domain: top_level_domain) }

      it { is_expected.to eq top_level_domain }
    end

    context 'when preset @top_level_domain from ENV' do
      let(:client) { described_class.new }
      let(:top_level_domain_env) { 'test-top-level-domain-env' }

      before do
        stub_const('ENV', { 'BACKLOG_TOP_LEVEL_DOMAIN' => top_level_domain_env })
      end

      it { is_expected.to eq top_level_domain_env }
    end
  end

  describe '#api_key' do
    subject { client.api_key }

    context 'when preset @api_key from args' do
      it { is_expected.to eq api_key }
    end

    context 'when preset @api_key from ENV' do
      let(:client) { described_class.new }
      let(:api_key_env) { 'test-api-key-env' }

      before do
        stub_const('ENV', { 'BACKLOG_API_KEY' => api_key_env })
      end

      it { is_expected.to eq api_key_env }
    end
  end

  describe '#client_id' do
    subject { client.client_id }

    context 'when preset @client_id from args' do
      let(:client) { described_class.new(client_id: client_id) }

      it { is_expected.to eq client_id }
    end

    context 'when preset @client_id from ENV' do
      let(:client) { described_class.new }
      let(:client_id_env) { 'test-client-id-env' }

      before do
        stub_const('ENV', { 'BACKLOG_OAUTH_CLIENT_ID' => client_id_env })
      end

      it { is_expected.to eq client_id_env }
    end
  end

  describe '#client_secret' do
    subject { client.client_secret }

    context 'when preset @client_secret from args' do
      let(:client_secret) { 'test-client-secret' }
      let(:client) { described_class.new(client_secret: client_secret) }

      it { is_expected.to eq client_secret }
    end

    context 'when preset @client_secret from ENV' do
      let(:client) { described_class.new }
      let(:client_secret_env) { 'test-client-secret-env' }

      before do
        stub_const('ENV', { 'BACKLOG_OAUTH_CLIENT_SECRET' => client_secret_env })
      end

      it { is_expected.to eq client_secret_env }
    end
  end

  describe '#refresh_token' do
    subject { client.refresh_token }

    context 'when preset @refresh_token from args' do
      let(:refresh_token) { 'test-refresh-token' }
      let(:client) { described_class.new(refresh_token: refresh_token) }

      it { is_expected.to eq refresh_token }
    end

    context 'when preset @refresh_token from ENV' do
      let(:client) { described_class.new }
      let(:refresh_token_env) { 'test-refresh-token-env' }

      before do
        stub_const('ENV', { 'BACKLOG_OAUTH_REFRESH_TOKEN' => refresh_token_env })
      end

      it { is_expected.to eq refresh_token_env }
    end
  end

  describe '#authorization_url' do
    let(:client) { described_class.new(initialized_params) }
    let(:redirect_uri) { 'http://example.com' }
    let(:state) { 'test-state' }

    let(:expected_base_url) { Regexp.escape("https://#{space_id}.backlog.jp/OAuth2AccessRequest.action") }
    let(:expected_base_params) { Regexp.escape("?response_type=code&client_id=#{client_id}") }
    let(:expected_redirect_uri) { Regexp.escape("&redirect_uri=#{redirect_uri}") }
    let(:expected_state) { Regexp.escape("&state=#{state}") }

    subject { client.authorization_url }

    context 'when preset @client_id' do
      let(:initialized_params) { { space_id: space_id, client_id: client_id } }

      it { is_expected.to match expected_base_url }
      it { is_expected.to match expected_base_params }
      it { is_expected.not_to match expected_redirect_uri }
      it { is_expected.not_to match expected_state }
    end

    context 'when preset @client_id and @redirect_uri' do
      let(:initialized_params) { { space_id: space_id, client_id: client_id, redirect_uri: redirect_uri } }

      it { is_expected.to match expected_base_url }
      it { is_expected.to match expected_base_params }
      it { is_expected.to match expected_redirect_uri }
      it { is_expected.not_to match expected_state }
    end

    context 'when preset @client_id and @state' do
      let(:initialized_params) { { space_id: space_id, client_id: client_id, state: state } }

      it { is_expected.to match expected_base_url }
      it { is_expected.to match expected_base_params }
      it { is_expected.not_to match expected_redirect_uri }
      it { is_expected.to match expected_state }
    end

    context 'when preset @client_id, @redirect_uri, and @state' do
      let(:initialized_params) do
        { space_id: space_id, client_id: client_id, redirect_uri: redirect_uri, state: state }
      end

      it { is_expected.to match expected_base_url }
      it { is_expected.to match expected_base_params }
      it { is_expected.to match expected_redirect_uri }
      it { is_expected.to match expected_state }
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

    context 'when rescue Faraday::ConnectionFailed' do
      let(:message) { 'getaddrinfo: nodename nor servname provided, or not known' }

      before do
        allow_any_instance_of(Faraday::Connection).to receive(:send).and_raise(Faraday::ConnectionFailed, message)
      end

      subject { -> { response } }
      it { is_expected.to raise_error(BacklogKit::Error, "ConnectionError - #{message}") }
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
    let(:client) { described_class.new(initialized_params) }
    let(:access_token) { 'test-access-token' }
    let(:request_method) { :get }
    let(:camelized_request_params) { { query: request_params } }
    let(:response_status) { 200 }
    let(:response) { client.get(request_path, underscored_request_params) }

    context 'when preset @access_token' do
      let(:initialized_params) { { space_id: space_id, api_key: nil, access_token: access_token } }

      before do
        stub_oauth_api_request
      end

      subject { response }

      it 'makes a oauth request' do
        subject
        expect(stub_oauth_api_request).to have_been_requested
      end
    end

    context 'when preset @api_key and @access_token' do
      let(:initialized_params) { { space_id: space_id, api_key: api_key, access_token: access_token } }
      it_behaves_like 'a normal http client'
    end
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

  let(:dummy_response) do
    {
      headers: { 'Content-Type' => 'application/json; charset=utf-8' },
      status: response_status,
      body: { 'test' => 'test' }.to_json
    }
  end

  def stub_api_request
    stub_request(request_method, "https://#{space_id}.backlog.jp/api/v2/#{request_path}?apiKey=#{api_key}")
      .with({ headers: { 'User-Agent' => described_class::USER_AGENT } }.merge(camelized_request_params))
      .to_return(dummy_response)
  end

  def stub_oauth_api_request
    stub_request(request_method, "https://#{space_id}.backlog.jp/api/v2/#{request_path}")
      .with({
        headers: {
          'User-Agent' => described_class::USER_AGENT,
          'Authorization' => "Bearer #{access_token}"
        }
      }.merge(camelized_request_params))
      .to_return(dummy_response)
  end
end
