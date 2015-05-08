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

shared_examples_for 'a normal response status' do
  describe '#status' do
    subject { response.status }
    it { is_expected.to eq status_code }
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

shared_examples_for 'raise errors' do
  let(:error_class_name) do
    BacklogKit::Response::RaiseError::CODE_ERRORS[error_code].name.demodulize
  end

  subject { lambda { response.on_complete(faraday_env_mock) } }
  it { is_expected.to raise_error(BacklogKit::Error, "[ERROR 1] #{error_class_name} - エラー1 (CODE: #{error_code}), [ERROR 2] #{error_class_name} - エラー2 (CODE: #{error_code})") }
end
