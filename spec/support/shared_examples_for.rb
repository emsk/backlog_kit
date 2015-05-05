shared_examples_for 'raise errors' do
  let(:error_class_name) do
    BacklogKit::Response::RaiseError::CODE_ERRORS[error_code].name.demodulize
  end

  subject { lambda { response.on_complete(faraday_env_mock) } }
  it { is_expected.to raise_error(BacklogKit::Error, "[ERROR 1] #{error_class_name} - エラー1 (CODE: #{error_code}), [ERROR 2] #{error_class_name} - エラー2 (CODE: #{error_code})") }
end
