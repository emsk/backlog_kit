require 'spec_helper'

describe BacklogKit::Client::Space do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_users', vcr: { cassette_name: 'user/get_users' } do
    let(:response) { client.get_users }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:user) { response.body[0] }
        it_behaves_like 'a resource of user'
      end
    end
  end

  describe '#get_user', vcr: { cassette_name: 'user/get_user' } do
    let(:response) { client.get_user(47893) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:user) { response.body }
      it_behaves_like 'a resource of user'
    end
  end

  describe '#create_user' do
    let(:response) { client.create_user(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 201 }

    context 'given valid params', vcr: { cassette_name: 'user/create_user_given_valid_params' } do
      let(:request_params) do
        {
          user_id: 'taro',
          password: 'password',
          name: 'テスト太郎',
          mail_address: 'taro@example.com',
          role_type: 6
        }
      end

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'

      describe '#body' do
        let(:user) { response.body }
        it_behaves_like 'a resource of user'
      end
    end

    context 'given invalid params', vcr: { cassette_name: 'user/create_user_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_user' do
    let(:response) { client.update_user(71333, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given valid params', vcr: { cassette_name: 'user/update_user_given_valid_params' } do
      let(:request_params) do
        {
          password: 'password',
          name: 'テスト花子',
          mail_address: 'hanako@example.com',
          role_type: 5
        }
      end

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'

      describe '#body' do
        let(:user) { response.body }
        it_behaves_like 'a resource of user'
      end
    end

    context 'given invalid params', vcr: { cassette_name: 'user/update_user_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#delete_user', vcr: { cassette_name: 'user/delete_user' } do
    let(:response) { client.delete_user(71333) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:user) { response.body }
      it_behaves_like 'a resource of user'
    end
  end

  describe '#get_myself', vcr: { cassette_name: 'user/get_myself' } do
    let(:response) { client.get_myself }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:user) { response.body }
      it_behaves_like 'a resource of user'
    end
  end

  describe '#download_user_icon', vcr: { cassette_name: 'user/download_user_icon' } do
    let(:response) { client.download_user_icon(47893) }
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

  describe '#get_user_activities' do
    shared_examples_for 'a response body of #get_user_activities' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:activity) { response.body[0] }
          it_behaves_like 'a resource of activity'
        end
      end
    end

    let(:response) { client.get_user_activities(56534, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'user/get_user_activities_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_activities'
    end

    context 'given valid params', vcr: { cassette_name: 'user/get_user_activities_given_valid_params' } do
      let(:request_params) { { activity_type_id: [1, 2] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_activities'
    end

    context 'given invalid params', vcr: { cassette_name: 'user/get_user_activities_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_user_stars' do
    shared_examples_for 'a response body of #get_user_stars' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:star) { response.body[0] }
          it_behaves_like 'a resource of star'
        end
      end
    end

    let(:response) { client.get_user_stars(56534, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'user/get_user_stars_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_stars'
    end

    context 'given valid params', vcr: { cassette_name: 'user/get_user_stars_given_valid_params' } do
      let(:request_params) { { min_id: 1 } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_stars'
    end

    context 'given invalid params', vcr: { cassette_name: 'user/get_user_stars_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_stars'
    end
  end

  describe '#get_user_star_count' do
    shared_examples_for 'a response body of #get_user_star_count' do
      describe '#body' do
        let(:count) { response.body }
        it_behaves_like 'a resource of count'
      end
    end

    let(:response) { client.get_user_star_count(56534, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'user/get_user_star_count_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_star_count'
    end

    context 'given valid params', vcr: { cassette_name: 'user/get_user_star_count_given_valid_params' } do
      let(:request_params) { { since: '2015-01-01' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_user_star_count'
    end

    context 'given invalid params', vcr: { cassette_name: 'user/get_user_star_count_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_recently_viewed_issues' do
    shared_examples_for 'a response body of #get_recently_viewed_issues' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:recently_viewed_issue) { response.body[0] }
          it_behaves_like 'a resource of recently viewed issue'
        end
      end
    end

    let(:response) { client.get_recently_viewed_issues(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'user/get_recently_viewed_issues_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_issues'
    end

    context 'given valid params', vcr: { cassette_name: 'user/get_recently_viewed_issues_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_issues'
    end

    context 'given invalid params', vcr: { cassette_name: 'user/get_recently_viewed_issues_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_issues'
    end
  end

  describe '#get_recently_viewed_projects' do
    shared_examples_for 'a response body of #get_recently_viewed_projects' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:recently_viewed_project) { response.body[0] }
          it_behaves_like 'a resource of recently viewed project'
        end
      end
    end

    let(:response) { client.get_recently_viewed_projects(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'user/get_recently_viewed_projects_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_projects'
    end

    context 'given valid params', vcr: { cassette_name: 'user/get_recently_viewed_projects_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_projects'
    end

    context 'given invalid params', vcr: { cassette_name: 'user/get_recently_viewed_projects_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_projects'
    end
  end

  describe '#get_recently_viewed_wikis' do
    shared_examples_for 'a response body of #get_recently_viewed_wikis' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:recently_viewed_wiki) { response.body[0] }
          it_behaves_like 'a resource of recently viewed wiki'
        end
      end
    end

    let(:response) { client.get_recently_viewed_wikis(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'user/get_recently_viewed_wikis_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_wikis'
    end

    context 'given valid params', vcr: { cassette_name: 'user/get_recently_viewed_wikis_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_wikis'
    end

    context 'given invalid params', vcr: { cassette_name: 'user/get_recently_viewed_wikis_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_recently_viewed_wikis'
    end
  end
end
