shared_examples_for 'a normal response' do
  subject { response }
  it { is_expected.to be_a BacklogKit::Response }
end

shared_examples_for 'a normal response headers' do
  describe '#headers' do
    subject { response.headers }

    it { is_expected.to be_a BacklogKit::Resource }
    it { is_expected.to respond_to('access-control-allow-origin') }
    it { is_expected.to respond_to(:access_control_allow_origin) }
    it { is_expected.to respond_to('content-type') }
    it { is_expected.to respond_to(:content_type) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:server) }
    it { is_expected.to respond_to('strict-transport-security') }
    it { is_expected.to respond_to(:strict_transport_security) }
    it { is_expected.to respond_to(:connection) }

    describe '#content_type' do
      subject { response.headers.content_type }
      it { is_expected.to eq content_type }
    end
  end
end

shared_examples_for 'a response headers of no content' do
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
    it { is_expected.to respond_to('content-length') }
    it { is_expected.to respond_to(:content_length) }
    it { is_expected.to respond_to(:connection) }
  end
end

shared_examples_for 'a normal response status' do
  describe '#status' do
    subject { response.status }
    it { is_expected.to eq status_code }
  end
end

shared_examples_for 'a response body of no content' do
  describe '#body' do
    subject { response.body }
    it { is_expected.to be_a BacklogKit::Resource }
  end
end

shared_examples_for 'a resource of activity' do
  subject { activity }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:project) }
  it { is_expected.to respond_to(:type) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:notifications) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }

  describe '#project' do
    let(:project) { activity.project }
    it_behaves_like 'a resource of project'
  end

  describe '#content' do
    subject { activity.content }
    it { is_expected.to be_a BacklogKit::Resource }
  end

  describe '#notifications' do
    subject { activity.notifications }
    it { is_expected.to be_a Array }
  end

  describe '#created_user' do
    let(:user) { activity.created_user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of category' do
  subject { category }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
end

shared_examples_for 'a resource of change log' do
  subject { change_log }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:field) }
  it { is_expected.to respond_to(:newValue) }
  it { is_expected.to respond_to(:new_value) }
  it { is_expected.to respond_to(:originalValue) }
  it { is_expected.to respond_to(:original_value) }
  it { is_expected.to respond_to(:attachmentInfo) }
  it { is_expected.to respond_to(:attachment_info) }
  it { is_expected.to respond_to(:attributeInfo) }
  it { is_expected.to respond_to(:attribute_info) }
  it { is_expected.to respond_to(:notificationInfo) }
  it { is_expected.to respond_to(:notification_info) }
end

shared_examples_for 'a resource of comment' do
  subject { comment }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:changeLog) }
  it { is_expected.to respond_to(:change_log) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updated) }
  it { is_expected.to respond_to(:stars) }
  it { is_expected.to respond_to(:notifications) }

  describe '#change_log' do
    subject { comment.change_log }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:change_log) { comment.change_log[0] }
      it_behaves_like 'a resource of change log'
    end
  end

  describe '#created_user' do
    let(:user) { comment.created_user }
    it_behaves_like 'a resource of user'
  end

  describe '#stars' do
    subject { comment.stars }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:star) { comment.stars[0] }
      it_behaves_like 'a resource of star'
    end
  end

  describe '#notifications' do
    subject { comment.notifications }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:notification) { comment.notifications[0] }
      it_behaves_like 'a resource of notification'
    end
  end
end

shared_examples_for 'a resource of count' do
  subject { count }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:count) }
end

shared_examples_for 'a resource of extended notification' do
  subject { extended_notification }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:alreadyRead) }
  it { is_expected.to respond_to(:already_read) }
  it { is_expected.to respond_to(:reason) }
  it { is_expected.to respond_to(:resourceAlreadyRead) }
  it { is_expected.to respond_to(:resource_already_read) }
  it { is_expected.to respond_to(:project) }
  it { is_expected.to respond_to(:issue) }
  it { is_expected.to respond_to(:comment) }
  it { is_expected.to respond_to(:sender) }
  it { is_expected.to respond_to(:created) }

  describe '#project' do
    let(:project) { extended_notification.project }
    it_behaves_like 'a resource of project'
  end

  describe '#issue' do
    let(:issue) { extended_notification.issue }
    it_behaves_like 'a resource of issue', attachment: true, shared_file: true, star: true
  end

  describe '#comment' do
    let(:comment) { extended_notification.comment }
    it_behaves_like 'a resource of comment'
  end

  describe '#sender' do
    let(:user) { extended_notification.sender }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of git repository' do
  subject { git_repository }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:hookUrl) }
  it { is_expected.to respond_to(:hook_url) }
  it { is_expected.to respond_to(:httpUrl) }
  it { is_expected.to respond_to(:http_url) }
  it { is_expected.to respond_to(:sshUrl) }
  it { is_expected.to respond_to(:ssh_url) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
  it { is_expected.to respond_to(:pushedAt) }
  it { is_expected.to respond_to(:pushed_at) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updatedUser) }
  it { is_expected.to respond_to(:updated_user) }
  it { is_expected.to respond_to(:updated) }

  describe '#created_user' do
    let(:user) { git_repository.created_user }
    it_behaves_like 'a resource of user'
  end

  describe '#updated_user' do
    let(:user) { git_repository.updated_user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of group' do |flags|
  subject { group }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:members) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updatedUser) }
  it { is_expected.to respond_to(:updated_user) }
  it { is_expected.to respond_to(:updated) }

  describe '#members' do
    subject { group.members }
    it { is_expected.to be_a Array }

    if flags[:member]
      describe '#[0]' do
        let(:user) { group.members[0] }
        it_behaves_like 'a resource of user'
      end
    else
      it { is_expected.to be_empty }
    end
  end

  describe '#created_user' do
    let(:user) { group.created_user }
    it_behaves_like 'a resource of user'
  end

  describe '#updated_user' do
    let(:user) { group.updated_user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of issue' do |flags|
  subject { issue }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:issueKey) }
  it { is_expected.to respond_to(:issue_key) }
  it { is_expected.to respond_to(:keyId) }
  it { is_expected.to respond_to(:key_id) }
  it { is_expected.to respond_to(:issueType) }
  it { is_expected.to respond_to(:issue_type) }
  it { is_expected.to respond_to(:summary) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:resolution) }
  it { is_expected.to respond_to(:priority) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:assignee) }
  it { is_expected.to respond_to(:category) }
  it { is_expected.to respond_to(:versions) }
  it { is_expected.to respond_to(:milestone) }
  it { is_expected.to respond_to(:startDate) }
  it { is_expected.to respond_to(:start_date) }
  it { is_expected.to respond_to(:dueDate) }
  it { is_expected.to respond_to(:due_date) }
  it { is_expected.to respond_to(:estimatedHours) }
  it { is_expected.to respond_to(:estimated_hours) }
  it { is_expected.to respond_to(:actualHours) }
  it { is_expected.to respond_to(:actual_hours) }
  it { is_expected.to respond_to(:parentIssueId) }
  it { is_expected.to respond_to(:parent_issue_id) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updatedUser) }
  it { is_expected.to respond_to(:updated_user) }
  it { is_expected.to respond_to(:updated) }
  it { is_expected.to respond_to(:customFields) }
  it { is_expected.to respond_to(:custom_fields) }
  it { is_expected.to respond_to(:attachments) }
  it { is_expected.to respond_to(:sharedFiles) }
  it { is_expected.to respond_to(:shared_files) }
  it { is_expected.to respond_to(:stars) }

  describe '#issue_type' do
    let(:issue_type) { issue.issue_type }
    it_behaves_like 'a resource of issue type'
  end

  describe '#resolution' do
    let(:resolution) { issue.resolution }
    it_behaves_like 'a resource of resolution'
  end

  describe '#priority' do
    let(:priority) { issue.priority }
    it_behaves_like 'a resource of priority'
  end

  describe '#status' do
    let(:status) { issue.status }
    it_behaves_like 'a resource of status'
  end

  describe '#assignee' do
    let(:user) { issue.assignee }
    it_behaves_like 'a resource of user'
  end

  describe '#category' do
    subject { issue.category }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:category) { issue.category[0] }
      it_behaves_like 'a resource of category'
    end
  end

  describe '#versions' do
    subject { issue.versions }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:version) { issue.versions[0] }
      it_behaves_like 'a resource of version'
    end
  end

  describe '#milestone' do
    subject { issue.milestone }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:milestone) { issue.milestone[0] }
      it_behaves_like 'a resource of milestone'
    end
  end

  describe '#created_user' do
    let(:user) { issue.created_user }
    it_behaves_like 'a resource of user'
  end

  describe '#updated_user' do
    let(:user) { issue.updated_user }
    it_behaves_like 'a resource of user'
  end

  describe '#custom_fields' do
    subject { issue.custom_fields }
    it { is_expected.to be_a Array }
  end

  describe '#attachments' do
    subject { issue.attachments }
    it { is_expected.to be_a Array }

    if flags[:attachment]
      describe '#[0]' do
        let(:issue_attachment) { issue.attachments[0] }
        it_behaves_like 'a resource of issue attachment'
      end
    else
      it { is_expected.to be_empty }
    end
  end

  describe '#shared_files' do
    subject { issue.shared_files }
    it { is_expected.to be_a Array }

    if flags[:shared_file]
      describe '#[0]' do
        let(:shared_file) { issue.shared_files[0] }
        it_behaves_like 'a resource of shared file'
      end
    else
      it { is_expected.to be_empty }
    end
  end

  describe '#stars' do
    subject { issue.stars }
    it { is_expected.to be_a Array }

    if flags[:star]
      describe '#[0]' do
        let(:star) { issue.stars[0] }
        it_behaves_like 'a resource of star'
      end
    else
      it { is_expected.to be_empty }
    end
  end
end

shared_examples_for 'a resource of issue attachment' do
  subject { issue_attachment }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:size) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }

  describe '#created_user' do
    let(:user) { issue_attachment.created_user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of issue type' do
  subject { issue_type }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:color) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
end

shared_examples_for 'a resource of milestone' do
  subject { milestone }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:startDate) }
  it { is_expected.to respond_to(:start_date) }
  it { is_expected.to respond_to(:releaseDueDate) }
  it { is_expected.to respond_to(:release_due_date) }
  it { is_expected.to respond_to(:archived) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
end

shared_examples_for 'a resource of notification' do
  subject { notification }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:alreadyRead) }
  it { is_expected.to respond_to(:already_read) }
  it { is_expected.to respond_to(:reason) }
  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:resourceAlreadyRead) }
  it { is_expected.to respond_to(:resource_already_read) }

  describe '#user' do
    let(:user) { notification.user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of priority' do
  subject { priority }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
end

shared_examples_for 'a resource of project' do
  subject { project }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectKey) }
  it { is_expected.to respond_to(:project_key) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:chartEnabled) }
  it { is_expected.to respond_to(:chart_enabled) }
  it { is_expected.to respond_to(:subtaskingEnabled) }
  it { is_expected.to respond_to(:subtasking_enabled) }
  it { is_expected.to respond_to(:textFormattingRule) }
  it { is_expected.to respond_to(:text_formatting_rule) }
  it { is_expected.to respond_to(:archived) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
end

shared_examples_for 'a resource of recently viewed issue' do
  subject { recently_viewed_issue }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:issue) }
  it { is_expected.to respond_to(:updated) }

  describe '#issue' do
    let(:issue) { recently_viewed_issue.issue }
    it_behaves_like 'a resource of issue', attachment: true, shared_file: true, star: true
  end
end

shared_examples_for 'a resource of recently viewed project' do
  subject { recently_viewed_project }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:project) }
  it { is_expected.to respond_to(:updated) }

  describe '#project' do
    let(:project) { recently_viewed_project.project }
    it_behaves_like 'a resource of project'
  end
end

shared_examples_for 'a resource of recently viewed wiki' do
  subject { recently_viewed_wiki }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:page) }
  it { is_expected.to respond_to(:updated) }

  describe '#page' do
    let(:wiki) { recently_viewed_wiki.page }
    it_behaves_like 'a resource of wiki'
  end
end

shared_examples_for 'a resource of resolution' do
  subject { resolution }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
end

shared_examples_for 'a resource of shared file' do
  subject { shared_file }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:type) }
  it { is_expected.to respond_to(:dir) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:size) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updatedUser) }
  it { is_expected.to respond_to(:updated_user) }
  it { is_expected.to respond_to(:updated) }

  describe '#created_user' do
    let(:user) { shared_file.created_user }
    it_behaves_like 'a resource of user'
  end

  describe '#updated_user' do
    let(:user) { shared_file.updated_user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of space' do
  subject { space }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:spaceKey) }
  it { is_expected.to respond_to(:space_key) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:ownerId) }
  it { is_expected.to respond_to(:owner_id) }
  it { is_expected.to respond_to(:lang) }
  it { is_expected.to respond_to(:timezone) }
  it { is_expected.to respond_to(:reportSendTime) }
  it { is_expected.to respond_to(:report_send_time) }
  it { is_expected.to respond_to(:textFormattingRule) }
  it { is_expected.to respond_to(:text_formatting_rule) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updated) }
end

shared_examples_for 'a resource of space attachment' do
  subject { space_attachment }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:size) }
end

shared_examples_for 'a resource of space disk usage' do
  subject { space_disk_usage }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:capacity) }
  it { is_expected.to respond_to(:issue) }
  it { is_expected.to respond_to(:wiki) }
  it { is_expected.to respond_to(:file) }
  it { is_expected.to respond_to(:subversion) }
  it { is_expected.to respond_to(:git) }
  it { is_expected.to respond_to(:details) }

  describe '#details' do
    subject { space_disk_usage.details }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:space_disk_usage_detail) { space_disk_usage.details[0] }
      it_behaves_like 'a resource of space disk usage detail'
    end
  end
end

shared_examples_for 'a resource of space disk usage detail' do
  subject { space_disk_usage_detail }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:issue) }
  it { is_expected.to respond_to(:wiki) }
  it { is_expected.to respond_to(:file) }
  it { is_expected.to respond_to(:subversion) }
  it { is_expected.to respond_to(:git) }
end

shared_examples_for 'a resource of space notification' do
  subject { space_notification }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:updated) }
end

shared_examples_for 'a resource of star' do
  subject { star }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:comment) }
  it { is_expected.to respond_to(:url) }
  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:presenter) }
  it { is_expected.to respond_to(:created) }

  describe '#presenter' do
    let(:user) { star.presenter }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource of status' do
  subject { status }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
end

shared_examples_for 'a resource of tag' do
  subject { tag }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:name) }
end

shared_examples_for 'a resource of user' do
  subject { user }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:userId) }
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:roleType) }
  it { is_expected.to respond_to(:role_type) }
  it { is_expected.to respond_to(:lang) }
  it { is_expected.to respond_to(:mailAddress) }
  it { is_expected.to respond_to(:mail_address) }
end

shared_examples_for 'a resource of version' do
  subject { version }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:startDate) }
  it { is_expected.to respond_to(:start_date) }
  it { is_expected.to respond_to(:releaseDueDate) }
  it { is_expected.to respond_to(:release_due_date) }
  it { is_expected.to respond_to(:archived) }
  it { is_expected.to respond_to(:displayOrder) }
  it { is_expected.to respond_to(:display_order) }
end

shared_examples_for 'a resource of wiki' do
  subject { wiki }

  it { is_expected.to be_a BacklogKit::Resource }
  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:projectId) }
  it { is_expected.to respond_to(:project_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:tags) }
  it { is_expected.to respond_to(:createdUser) }
  it { is_expected.to respond_to(:created_user) }
  it { is_expected.to respond_to(:created) }
  it { is_expected.to respond_to(:updatedUser) }
  it { is_expected.to respond_to(:updated_user) }
  it { is_expected.to respond_to(:updated) }

  describe '#tags' do
    subject { wiki.tags }
    it { is_expected.to be_a Array }

    describe '#[0]' do
      let(:tag) { wiki.tags[0] }
      it_behaves_like 'a resource of tag'
    end
  end

  describe '#created_user' do
    let(:user) { wiki.created_user }
    it_behaves_like 'a resource of user'
  end

  describe '#updated_user' do
    let(:user) { wiki.updated_user }
    it_behaves_like 'a resource of user'
  end
end

shared_examples_for 'a resource file' do
  subject { resource_file }

  it { is_expected.to be_a BacklogKit::ResourceFile }
  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:filename) }
end

shared_examples_for 'a invalid request error' do
  subject { lambda { response.body } }
  it { is_expected.to raise_error(BacklogKit::Error, "[ERROR 1] InvalidRequestError - error.unknownParameter : #{invalid_param_key} (CODE: 7)") }
end

shared_examples_for 'raise errors' do
  let(:error_class_name) do
    BacklogKit::Response::RaiseError::CODE_ERRORS[error_code].name.demodulize
  end

  subject { lambda { response.on_complete(faraday_env_mock) } }
  it { is_expected.to raise_error(BacklogKit::Error, "[ERROR 1] #{error_class_name} - エラー1 (CODE: #{error_code}), [ERROR 2] #{error_class_name} - エラー2 (CODE: #{error_code})") }
end
