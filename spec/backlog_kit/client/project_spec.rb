require 'spec_helper'

describe BacklogKit::Client::Project do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_projects' do
    shared_examples_for 'a response body of #get_projects' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:project) { response.body[0] }
          it_behaves_like 'a resource of project'
        end
      end
    end

    let(:response) { client.get_projects(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given valid params', vcr: { cassette_name: 'project/get_projects_given_valid_params' } do
      let(:request_params) { { archived: false } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_projects'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/get_projects_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_projects'
    end
  end

  shared_examples_for 'a response body of project' do
    describe '#body' do
      let(:project) { response.body }
      it_behaves_like 'a resource of project' 
    end
  end

  let(:project_id) { 31224 }

  describe '#get_project', vcr: { cassette_name: 'project/get_project' } do
    let(:response) { client.get_project(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of project'
  end

  describe '#create_project' do
    let(:response) { client.create_project(project_key, project_name, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 201 }

    context 'given valid params', vcr: { cassette_name: 'project/create_project_given_valid_params' } do
      let(:project_key) { 'TEST_PROJECT_1' }
      let(:project_name) { 'テストプロジェクト1' }
      let(:request_params) { { chart_enabled: false, subtasking_enabled: false, text_formatting_rule: 'backlog' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of project'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/create_project_given_invalid_params' } do
      let(:project_key) { 'TEST_PROJECT_2' }
      let(:project_name) { 'テストプロジェクト2' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_project' do
    let(:response) { client.update_project(project_id, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/update_project_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of project'
    end

    context 'given valid params', vcr: { cassette_name: 'project/update_project_given_valid_params' } do
      let(:request_params) { { name: 'テストプロジェクト1' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of project'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/update_project_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#delete_project', vcr: { cassette_name: 'project/delete_project' } do
    let(:response) { client.delete_project(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of project'
  end

  describe '#download_project_icon', vcr: { cassette_name: 'project/download_project_icon' } do
    let(:response) { client.download_project_icon(project_id) }
    let(:content_type) { 'image/jpeg' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:resource_file) { response.body }
      it_behaves_like 'a resource file'
    end
  end

  describe '#get_project_activities' do
    shared_examples_for 'a response body of #get_project_activities' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:activity) { response.body[0] }
          it_behaves_like 'a resource of activity'
        end
      end
    end

    let(:response) { client.get_project_activities(project_id, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/get_project_activities_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_project_activities'
    end

    context 'given valid params', vcr: { cassette_name: 'project/get_project_activities_given_valid_params' } do
      let(:request_params) { { activity_type_id: [1, 2] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_project_activities'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/get_project_activities_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_project_users', vcr: { cassette_name: 'project/get_project_users' } do
    let(:response) { client.get_project_users(project_id) }
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

  shared_examples_for 'a response body of user' do
    describe '#body' do
      let(:user) { response.body }
      it_behaves_like 'a resource of user'
    end
  end

  describe '#add_project_user', vcr: { cassette_name: 'project/add_project_user' } do
    let(:response) { client.add_project_user(project_id, 62380) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of user'
  end

  describe '#remove_project_user', vcr: { cassette_name: 'project/remove_project_user' } do
    let(:response) { client.remove_project_user(project_id, 62380) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of user'
  end

  describe '#get_project_administrators', vcr: { cassette_name: 'project/get_project_administrators' } do
    let(:response) { client.get_project_administrators(project_id) }
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

  describe '#add_project_admin_auth', vcr: { cassette_name: 'project/add_project_admin_auth' } do
    let(:response) { client.add_project_admin_auth(project_id, 56534) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of user'
  end

  describe '#remove_project_admin_auth', vcr: { cassette_name: 'project/remove_project_admin_auth' } do
    let(:response) { client.remove_project_admin_auth(project_id, 56534) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of user'
  end

  describe '#get_issue_types', vcr: { cassette_name: 'project/get_issue_types' } do
    let(:response) { client.get_issue_types(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:issue_type) { response.body[0] }
        it_behaves_like 'a resource of issue type'
      end
    end
  end

  shared_examples_for 'a response body of issue type' do
    describe '#body' do
      let(:issue_type) { response.body }
      it_behaves_like 'a resource of issue type'
    end
  end

  describe '#add_issue_type', vcr: { cassette_name: 'project/add_issue_type' } do
    let(:response) { client.add_issue_type(project_id, 'テスト種別1', '#e30000') }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of issue type'
  end

  describe '#update_issue_type' do
    let(:response) { client.update_issue_type(project_id, 138339, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/update_issue_type_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of issue type'
    end

    context 'given valid params', vcr: { cassette_name: 'project/update_issue_type_given_valid_params' } do
      let(:request_params) { { name: 'テスト種別2' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of issue type'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/update_issue_type_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#remove_issue_type', vcr: { cassette_name: 'project/remove_issue_type' } do
    let(:response) { client.remove_issue_type(project_id, 138339, 136774) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of issue type'
  end

  describe '#get_categories', vcr: { cassette_name: 'project/get_categories' } do
    let(:response) { client.get_categories(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:category) { response.body[0] }
        it_behaves_like 'a resource of category'
      end
    end
  end

  shared_examples_for 'a response body of category' do
    describe '#body' do
      let(:category) { response.body }
      it_behaves_like 'a resource of category'
    end
  end

  describe '#add_category', vcr: { cassette_name: 'project/add_category' } do
    let(:response) { client.add_category(project_id, 'テストカテゴリー1') }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of category'
  end

  describe '#update_category', vcr: { cassette_name: 'project/update_category' } do
    let(:response) { client.update_category(project_id, 66199, 'テストカテゴリー2') }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of category'
  end

  describe '#remove_category', vcr: { cassette_name: 'project/remove_category' } do
    let(:response) { client.remove_category(project_id, 66199) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of category'
  end

  describe '#get_versions', vcr: { cassette_name: 'project/get_versions' } do
    let(:response) { client.get_versions(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:version) { response.body[0] }
        it_behaves_like 'a resource of version'
      end
    end
  end

  shared_examples_for 'a response body of version' do
    describe '#body' do
      let(:version) { response.body }
      it_behaves_like 'a resource of version'
    end
  end

  describe '#add_version', vcr: { cassette_name: 'project/add_version' } do
    let(:response) { client.add_version(project_id, version_name, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/add_version_given_no_params' } do
      let(:version_name) { 'テストバージョン1' }
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of version'
    end

    context 'given valid params', vcr: { cassette_name: 'project/add_version_given_valid_params' } do
      let(:version_name) { 'テストバージョン2' }
      let(:request_params) { { description: 'テストバージョン2の詳細です。', start_date: '2015-05-01', release_due_date: '2015-05-31' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of version'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/add_version_given_invalid_params' } do
      let(:version_name) { 'テストバージョン3' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_version' do
    let(:response) { client.update_version(project_id, 39682, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/update_version_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of version'
    end

    context 'given valid params', vcr: { cassette_name: 'project/update_version_given_valid_params' } do
      let(:request_params) { { name: 'テストバージョン4' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of version'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/update_version_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#remove_version', vcr: { cassette_name: 'project/remove_version' } do
    let(:response) { client.remove_version(project_id, 39682) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of version'
  end

  describe '#get_shared_files' do
    shared_examples_for 'a response body of #get_shared_files' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:shared_file) { response.body[0] }
          it_behaves_like 'a resource of shared file'
        end
      end
    end

    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/get_shared_files_given_no_params' } do
      let(:response) { client.get_shared_files(project_id) }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_shared_files'
    end

    context 'given valid params', vcr: { cassette_name: 'project/get_shared_files_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }
      let(:response) { client.get_shared_files(project_id, '', request_params) }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_shared_files'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/get_shared_files_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }
      let(:response) { client.get_shared_files(project_id, '', request_params) }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_shared_files'
    end
  end

  describe '#download_shared_file', vcr: { cassette_name: 'project/download_shared_file' } do
    let(:response) { client.download_shared_file(project_id, 2654538) }
    let(:content_type) { 'text/plain' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:resource_file) { response.body }
      it_behaves_like 'a resource file'
    end
  end

  describe '#get_project_disk_usage', vcr: { cassette_name: 'project/get_project_disk_usage' } do
    let(:response) { client.get_project_disk_usage(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:project_disk_usage) { response.body }
      it_behaves_like 'a resource of project disk usage'
    end
  end

  describe '#get_webhooks', vcr: { cassette_name: 'project/get_webhooks' } do
    let(:response) { client.get_webhooks(project_id) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:webhook) { response.body[0] }
        it_behaves_like 'a resource of webhook'
      end
    end
  end

  shared_examples_for 'a response body of webhook' do
    describe '#body' do
      let(:webhook) { response.body }
      it_behaves_like 'a resource of webhook' 
    end
  end

  describe '#get_webhook', vcr: { cassette_name: 'project/get_webhook' } do
    let(:response) { client.get_webhook(project_id, 105) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of webhook'
  end

  describe '#add_webhook' do
    let(:response) { client.add_webhook(project_id, 'テストウェブフック1', 'https://example.com', request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given valid params', vcr: { cassette_name: 'project/add_webhook_given_valid_params' } do
      let(:request_params) { { all_event: false, activity_type_ids: [1, 2] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of webhook'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/add_webhook_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_webhook' do
    let(:response) { client.update_webhook(project_id, 106, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'project/update_webhook_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of webhook'
    end

    context 'given valid params', vcr: { cassette_name: 'project/update_webhook_given_valid_params' } do
      let(:request_params) { { name: 'テストウェブフック2' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of webhook'
    end

    context 'given invalid params', vcr: { cassette_name: 'project/update_webhook_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#remove_webhook', vcr: { cassette_name: 'project/remove_webhook' } do
    let(:response) { client.remove_webhook(project_id, 106) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of webhook'
  end
end
