describe BacklogKit::Client::Space do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  let(:user_id) { 56534 }

  describe '#get_watchings' do
    shared_examples_for 'a response body of #get_watchings' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:watching) { response.body[0] }
          it_behaves_like 'a resource of watching'
        end
      end
    end

    let(:response) { client.get_watchings(user_id, request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'watching/get_watchings_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_watchings'
    end

    context 'given valid params', vcr: { cassette_name: 'watching/get_watchings_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_watchings'
    end

    context 'given invalid params', vcr: { cassette_name: 'watching/get_watchings_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_watching_count' do
    shared_examples_for 'a response body of #get_watching_count' do
      describe '#body' do
        let(:count) { response.body }
        it_behaves_like 'a resource of count'
      end
    end

    let(:response) { client.get_watching_count(user_id, request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'watching/get_watching_count_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_watching_count'
    end

    context 'given valid params', vcr: { cassette_name: 'watching/get_watching_count_given_valid_params' } do
      let(:request_params) { { already_read: true } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_watching_count'
    end

    context 'given invalid params', vcr: { cassette_name: 'watching/get_watching_count_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_watching_count'
    end
  end

  shared_examples_for 'a response body of watching' do
    describe '#body' do
      let(:watching) { response.body }
      it_behaves_like 'a resource of watching'
    end
  end

  let(:watching_id) { 13883 }

  describe '#get_watching', vcr: { cassette_name: 'watching/get_watching' } do
    let(:response) { client.get_watching(watching_id) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of watching'
  end

  describe '#add_watching' do
    let(:response) { client.add_watching(issue_id, request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 201 }

    context 'given no params', vcr: { cassette_name: 'watching/add_watching_given_no_params' } do
      let(:issue_id) { 1267084 }
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of watching'
    end

    context 'given valid params', vcr: { cassette_name: 'watching/add_watching_given_valid_params' } do
      let(:issue_id) { 1267095 }
      let(:request_params) { { note: 'テストウォッチ1' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of watching'
    end

    context 'given invalid params', vcr: { cassette_name: 'watching/add_watching_given_invalid_params' } do
      let(:issue_id) { 1267095 }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_watching' do
    let(:response) { client.update_watching(watching_id, request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'watching/update_watching_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of watching'
    end

    context 'given valid params', vcr: { cassette_name: 'watching/update_watching_given_valid_params' } do
      let(:request_params) { { note: 'テストウォッチ2' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of watching'
    end

    context 'given invalid params', vcr: { cassette_name: 'watching/update_watching_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#remove_watching', vcr: { cassette_name: 'watching/remove_watching' } do
    let(:response) { client.remove_watching(watching_id) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of watching'
  end

  describe '#mark_as_read_watchings', vcr: { cassette_name: 'watching/mark_as_read_watchings' } do
    let(:response) { client.mark_as_read_watchings(user_id) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'

    describe '#headers' do
      subject { response.headers }

      it { is_expected.to be_a BacklogKit::Resource }
      it { is_expected.to respond_to('access-control-allow-origin') }
      it { is_expected.to respond_to(:access_control_allow_origin) }
      it { is_expected.not_to respond_to('content-type') }
      it { is_expected.not_to respond_to(:content_type) }
      it { is_expected.to respond_to(:date) }
      it { is_expected.to respond_to(:server) }
      it { is_expected.to respond_to('strict-transport-security') }
      it { is_expected.to respond_to(:strict_transport_security) }
      it { is_expected.not_to respond_to('content-length') }
      it { is_expected.not_to respond_to(:content_length) }
      it { is_expected.to respond_to(:connection) }
    end

    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end

  describe '#mark_as_read_watching', vcr: { cassette_name: 'watching/mark_as_read_watching' } do
    let(:watching_id) { 17177 }
    let(:response) { client.mark_as_read_watching(watching_id) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'

    describe '#headers' do
      subject { response.headers }

      it { is_expected.to be_a BacklogKit::Resource }
      it { is_expected.to respond_to('access-control-allow-origin') }
      it { is_expected.to respond_to(:access_control_allow_origin) }
      it { is_expected.not_to respond_to('content-type') }
      it { is_expected.not_to respond_to(:content_type) }
      it { is_expected.to respond_to(:date) }
      it { is_expected.to respond_to(:server) }
      it { is_expected.to respond_to('strict-transport-security') }
      it { is_expected.to respond_to(:strict_transport_security) }
      it { is_expected.not_to respond_to('content-length') }
      it { is_expected.not_to respond_to(:content_length) }
      it { is_expected.to respond_to(:connection) }
    end

    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end
end
