describe BacklogKit::Client::Authorization do
  shared_examples_for 'a response body of oauth token' do
    describe '#body' do
      let(:oauth_token) { response.body }
      it_behaves_like 'a resource of oauth token'
    end
  end

  describe '#create_token' do
    let(:response) { client.create_token(oauth_code) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'when @redirect_uri is not nil', vcr: { cassette_name: 'authorization/create_token_when_redirect_uri_is_not_nil' } do
      let(:client) do
        BacklogKit::Client.new(
          space_id: ENV['BACKLOG_SPACE_ID'],
          api_key: nil,
          client_id: ENV['BACKLOG_OAUTH_CLIENT_ID'],
          client_secret: ENV['BACKLOG_OAUTH_CLIENT_SECRET'],
          redirect_uri: 'http://localhost:3000'
        )
      end
      let(:oauth_code) { 'zyBC0O8bZ4vbLSlNq63duWedIFv2GVcp1GZ3A318ejs39VhaNfleOkr9UctoWagg' }

      it_behaves_like 'a normal response'
      it_behaves_like 'a response headers of no access control allow origin'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of oauth token'
    end

    context 'when @redirect_uri is nil', vcr: { cassette_name: 'authorization/create_token_when_redirect_uri_is_nil' } do
      let(:client) do
        BacklogKit::Client.new(
          space_id: ENV['BACKLOG_SPACE_ID'],
          api_key: nil,
          client_id: ENV['BACKLOG_OAUTH_CLIENT_ID'],
          client_secret: ENV['BACKLOG_OAUTH_CLIENT_SECRET']
        )
      end
      let(:oauth_code) { 'WhVABrmYpwnKQIJIaDxBJ8vShhSPDvPzz8OJtD6HedFWZ8M3HOODZGthp6gakDpY' }

      it_behaves_like 'a normal response'
      it_behaves_like 'a response headers of no access control allow origin'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of oauth token'
    end
  end

  describe '#update_token', vcr: { cassette_name: 'authorization/update_token' } do
    let(:client) do
      BacklogKit::Client.new(
        space_id: ENV['BACKLOG_SPACE_ID'],
        api_key: nil,
        client_id: ENV['BACKLOG_OAUTH_CLIENT_ID'],
        client_secret: ENV['BACKLOG_OAUTH_CLIENT_SECRET'],
        refresh_token: ENV['BACKLOG_OAUTH_REFRESH_TOKEN']
      )
    end
    let(:response) { client.update_token }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no access control allow origin'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of oauth token'
  end
end
