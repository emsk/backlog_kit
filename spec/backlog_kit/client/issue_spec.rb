describe BacklogKit::Client::Issue do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_issues' do
    shared_examples_for 'a response body of #get_issues' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:issue) { response.body[0] }
          it_behaves_like 'a resource of issue', {
            resolution: true,
            assignee: true,
            category: true,
            version: true,
            milestone: true,
            attachment: true,
            shared_file: true,
            star: true
          }
        end
      end
    end

    let(:response) { client.get_issues(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given valid params', vcr: { cassette_name: 'issue/get_issues_given_valid_params' } do
      let(:request_params) { { project_id: [31224] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_issues'
    end

    context 'given invalid params', vcr: { cassette_name: 'issue/get_issues_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_issue_count' do
    shared_examples_for 'a response body of #get_issue_count' do
      describe '#body' do
        let(:count) { response.body }
        it_behaves_like 'a resource of count'
      end
    end

    let(:response) { client.get_issue_count(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'issue/get_issue_count_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_issue_count'
    end

    context 'given valid params', vcr: { cassette_name: 'issue/get_issue_count_given_valid_params' } do
      let(:request_params) { { project_id: [31224] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_issue_count'
    end

    context 'given invalid params', vcr: { cassette_name: 'issue/get_issue_count_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_issue', vcr: { cassette_name: 'issue/get_issue' } do
    let(:response) { client.get_issue(1189073) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:issue) { response.body }
      it_behaves_like 'a resource of issue', {
        resolution: true,
        assignee: true,
        category: true,
        version: true,
        milestone: true,
        attachment: true,
        shared_file: true,
        star: true
      }
    end
  end

  shared_examples_for 'a response body of issue' do |flags|
    describe '#body' do
      let(:issue) { response.body }
      it_behaves_like 'a resource of issue', flags
    end
  end

  describe '#create_issue' do
    let(:response) { client.create_issue(summary, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 201 }

    context 'given valid params', vcr: { cassette_name: 'issue/create_issue_given_valid_params' } do
      let(:summary) { 'テスト課題1' }
      let(:request_params) { { project_id: 31224, issue_type_id: 1, priority_id: 2 } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of issue', {
        resolution: false,
        assignee: false,
        category: false,
        version: false,
        milestone: false,
        attachment: false,
        shared_file: false,
        star: false
      }
    end

    context 'given invalid params', vcr: { cassette_name: 'issue/create_issue_given_invalid_params' } do
      let(:summary) { 'dummy2' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_issue' do
    let(:response) { client.update_issue(1190003, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'issue/update_issue_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of issue', {
        resolution: false,
        assignee: false,
        category: false,
        version: false,
        milestone: false,
        attachment: false,
        shared_file: false,
        star: false
      }
    end

    context 'given valid params', vcr: { cassette_name: 'issue/update_issue_given_valid_params' } do
      let(:request_params) { { summary: 'テスト課題2' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of issue', {
        resolution: false,
        assignee: false,
        category: false,
        version: false,
        milestone: false,
        attachment: false,
        shared_file: false,
        star: false
      }
    end

    context 'given invalid params', vcr: { cassette_name: 'issue/update_issue_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#delete_issue', vcr: { cassette_name: 'issue/delete_issue' } do
    let(:response) { client.delete_issue(1190003) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of issue', {
      resolution: false,
      assignee: false,
      category: false,
      version: false,
      milestone: false,
      attachment: false,
      shared_file: false,
      star: false
    }
  end

  describe '#get_comments' do
    shared_examples_for 'a response body of #get_comments' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:comment) { response.body[0] }
          it_behaves_like 'a resource of comment', change_log: true, star: true, notification: true
        end
      end
    end

    let(:response) { client.get_comments(1189073, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'issue/get_comments_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_comments'
    end

    context 'given valid params', vcr: { cassette_name: 'issue/get_comments_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_comments'
    end

    context 'given invalid params', vcr: { cassette_name: 'issue/get_comments_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_comments'
    end
  end

  describe '#get_comment_count', vcr: { cassette_name: 'issue/get_comment_count' } do
    let(:response) { client.get_comment_count(1189073) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:count) { response.body }
      it_behaves_like 'a resource of count'
    end
  end

  describe '#get_comment', vcr: { cassette_name: 'issue/get_comment' } do
    let(:response) { client.get_comment(1189073, 5328775) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:comment) { response.body }
      it_behaves_like 'a resource of comment', change_log: true, star: true, notification: true
    end
  end

  shared_examples_for 'a response body of comment' do |flags|
    describe '#body' do
      let(:comment) { response.body }
      it_behaves_like 'a resource of comment', flags
    end
  end

  describe '#add_comment' do
    let(:response) { client.add_comment(1188856, content, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 201 }

    context 'given no params', vcr: { cassette_name: 'issue/add_comment_given_no_params' } do
      let(:content) { 'テストコメント1' }
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of comment', change_log: false, star: false, notification: false
    end

    context 'given valid params', vcr: { cassette_name: 'issue/add_comment_given_valid_params' } do
      let(:content) { 'テストコメント2' }
      let(:request_params) { { notified_user_id: [56534] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of comment', change_log: false, star: false, notification: true
    end

    context 'given invalid params', vcr: { cassette_name: 'issue/add_comment_given_invalid_params' } do
      let(:content) { 'テストコメント3' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_comment', vcr: { cassette_name: 'issue/update_comment' } do
    let(:response) { client.update_comment(1188856, 5328861, 'テストコメント4') }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of comment', change_log: false, star: false, notification: false
  end

  describe '#delete_comment', vcr: { cassette_name: 'issue/delete_comment' } do
    let(:response) { client.delete_comment(1267081, 60926684) }
    let(:content_type) { 'application/json' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of comment', change_log: false, star: false, notification: false
  end

  describe '#get_comment_notifications', vcr: { cassette_name: 'issue/get_comment_notifications' } do
    let(:response) { client.get_comment_notifications(1188856, 5328877) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:notification) { response.body[0] }
        it_behaves_like 'a resource of notification'
      end
    end
  end

  describe '#add_comment_notification' do
    shared_examples_for 'a response body of #add_comment_notification' do |flags|
      describe '#body' do
        let(:comment) { response.body }
        it_behaves_like 'a resource of comment', flags
      end
    end

    let(:response) { client.add_comment_notification(1188856, 5328861, request_notified_user_ids) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no notified_user_ids', vcr: { cassette_name: 'issue/add_comment_notification_given_no_notified_user_ids' } do
      let(:request_notified_user_ids) { [] }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #add_comment_notification', change_log: false, star: false, notification: false
    end

    context 'given notified_user_ids', vcr: { cassette_name: 'issue/add_comment_notification_given_notified_user_ids' } do
      let(:request_notified_user_ids) { [56534] }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #add_comment_notification', change_log: false, star: false, notification: true
    end
  end

  describe '#get_issue_attachments', vcr: { cassette_name: 'issue/get_issue_attachments' } do
    let(:response) { client.get_issue_attachments(1188856) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:issue_attachment) { response.body[0] }
        it_behaves_like 'a resource of issue attachment'
      end
    end
  end

  describe '#download_issue_attachment', vcr: { cassette_name: 'issue/download_issue_attachment' } do
    let(:response) { client.download_issue_attachment(1188856, 535387) }
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

  describe '#remove_issue_attachment', vcr: { cassette_name: 'issue/remove_issue_attachment' } do
    let(:response) { client.remove_issue_attachment(1188856, 535387) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:issue_attachment) { response.body }
      it_behaves_like 'a resource of issue attachment'
    end
  end

  describe '#get_issue_shared_files', vcr: { cassette_name: 'issue/get_issue_shared_files' } do
    let(:response) { client.get_issue_shared_files(1188856) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:shared_file) { response.body[0] }
        it_behaves_like 'a resource of shared file'
      end
    end
  end

  describe '#link_issue_shared_files', vcr: { cassette_name: 'issue/link_issue_shared_files' } do
    let(:response) { client.link_issue_shared_files(1188856, [2654538]) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:shared_file) { response.body[0] }
        it_behaves_like 'a resource of shared file'
      end
    end
  end

  describe '#unlink_issue_shared_file', vcr: { cassette_name: 'issue/unlink_issue_shared_file' } do
    let(:response) { client.unlink_issue_shared_file(1188856, 2654538) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:shared_file) { response.body }
      it_behaves_like 'a resource of shared file'
    end
  end
end
