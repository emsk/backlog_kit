describe BacklogKit::Client::Space do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_space', vcr: { cassette_name: 'space/get_space' } do
    let(:response) { client.get_space }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:space) { response.body }
      it_behaves_like 'a resource of space'
    end
  end

  describe '#get_space_activities' do
    shared_examples_for 'a response body of #get_space_activities' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:activity) { response.body[0] }
          it_behaves_like 'a resource of activity'
        end
      end
    end

    let(:response) { client.get_space_activities(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'space/get_space_activities_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_space_activities'
    end

    context 'given valid params', vcr: { cassette_name: 'space/get_space_activities_given_valid_params' } do
      let(:request_params) { { activity_type_id: [1, 2] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_space_activities'
    end

    context 'given invalid params', vcr: { cassette_name: 'space/get_space_activities_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#download_space_icon', vcr: { cassette_name: 'space/download_space_icon' } do
    let(:response) { client.download_space_icon }
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

  describe '#get_space_notification', vcr: { cassette_name: 'space/get_space_notification' } do
    let(:response) { client.get_space_notification }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:space_notification) { response.body }
      it_behaves_like 'a resource of space notification'
    end
  end

  describe '#update_space_notification', vcr: { cassette_name: 'space/update_space_notification' } do
    let(:response) { client.update_space_notification('テスト更新1') }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:space_notification) { response.body }
      it_behaves_like 'a resource of space notification'
    end
  end

  describe '#get_space_disk_usage', vcr: { cassette_name: 'space/get_space_disk_usage' } do
    let(:response) { client.get_space_disk_usage }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:space_disk_usage) { response.body }
      it_behaves_like 'a resource of space disk usage'
    end
  end

  describe '#upload_attachment', vcr: { cassette_name: 'space/upload_attachment' } do
    let(:response) { client.upload_attachment(__FILE__) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:space_attachment) { response.body }
      it_behaves_like 'a resource of space attachment'
    end
  end
end
