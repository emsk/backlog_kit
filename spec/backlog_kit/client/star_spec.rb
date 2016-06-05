describe BacklogKit::Client::Status do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#add_issue_star', vcr: { cassette_name: 'star/add_issue_star' } do
    let(:response) { client.add_issue_star(1188856) }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no content'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end

  describe '#add_issue_comment_star', vcr: { cassette_name: 'star/add_issue_comment_star' } do
    let(:response) { client.add_issue_comment_star(5324479) }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no content'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end

  describe '#add_wiki_star', vcr: { cassette_name: 'star/add_wiki_star' } do
    let(:response) { client.add_wiki_star(80179) }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no content'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end

  describe '#add_pull_request_star', vcr: { cassette_name: 'star/add_pull_request_star' } do
    let(:response) { client.add_pull_request_star(62) }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no content'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end

  describe '#add_pull_request_comment_star', vcr: { cassette_name: 'star/add_pull_request_comment_star' } do
    let(:response) { client.add_pull_request_comment_star(168) }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no content'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end
end
