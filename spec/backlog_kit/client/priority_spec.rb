describe BacklogKit::Client::Priority do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_priorities', vcr: { cassette_name: 'priority/get_priorities' } do
    let(:response) { client.get_priorities }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:priority) { response.body[0] }
        it_behaves_like 'a resource of priority'
      end
    end
  end
end
