describe BacklogKit::Client::Team do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_teams' do
    shared_examples_for 'a response body of #get_teams' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:team) { response.body[0] }
          it_behaves_like 'a resource of team', member: true
        end
      end
    end

    let(:response) { client.get_teams(request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'team/get_teams_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_teams'
    end

    context 'given valid params', vcr: { cassette_name: 'team/get_teams_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_teams'
    end

    context 'given invalid params', vcr: { cassette_name: 'team/get_teams_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_teams'
    end
  end

  describe '#get_team', vcr: { cassette_name: 'team/get_team' } do
    let(:response) { client.get_team(3089) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:team) { response.body }
      it_behaves_like 'a resource of team', member: true
    end
  end

  shared_examples_for 'a response body of team' do |flags|
    describe '#body' do
      let(:team) { response.body }
      it_behaves_like 'a resource of team', flags
    end
  end

  describe '#create_team' do
    let(:response) { client.create_team(name, request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'team/create_team_given_no_params' } do
      let(:name) { 'テストチーム1' }
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of team', member: false
    end

    context 'given valid params', vcr: { cassette_name: 'team/create_team_given_valid_params' } do
      let(:name) { 'テストチーム2' }
      let(:request_params) { { members: [47893, 56534] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of team', member: true
    end

    context 'given invalid params', vcr: { cassette_name: 'team/create_team_given_invalid_params' } do
      let(:name) { 'テストチーム3' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_team' do
    let(:response) { client.update_team(3089, request_params) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'team/update_team_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of team', member: true
    end

    context 'given valid params', vcr: { cassette_name: 'team/update_team_given_valid_params' } do
      let(:request_params) { { name: 'テストチーム4' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of team', member: true
    end

    context 'given invalid params', vcr: { cassette_name: 'team/update_team_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#delete_team', vcr: { cassette_name: 'team/delete_team' } do
    let(:response) { client.delete_team(3758) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of team', member: true
  end

  describe '#download_team_icon', vcr: { cassette_name: 'team/download_team_icon' } do
    let(:response) { client.download_team_icon(3089) }
    let(:content_type) { 'image/png' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:resource_file) { response.body }
      it_behaves_like 'a resource file'
    end
  end
end
