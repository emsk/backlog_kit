require 'spec_helper'

describe BacklogKit::Client::Notification do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_notifications' do
    shared_examples_for 'a response body of #get_notifications' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:extended_notification) { response.body[0] }
          it_behaves_like 'a resource of extended notification'
        end
      end
    end

    let(:response) { client.get_notifications(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'notification/get_notifications_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_notifications'
    end

    context 'given valid params', vcr: { cassette_name: 'notification/get_notifications_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_notifications'
    end

    context 'given invalid params', vcr: { cassette_name: 'notification/get_notifications_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_notifications'
    end
  end

  describe '#get_notification_count' do
    shared_examples_for 'a response body of #get_notification_count' do
      describe '#body' do
        let(:count) { response.body }
        it_behaves_like 'a resource of count'
      end
    end

    let(:response) { client.get_notification_count(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'notification/get_notification_count_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_notification_count'
    end

    context 'given valid params', vcr: { cassette_name: 'notification/get_notification_count_given_valid_params' } do
      let(:request_params) { { already_read: false } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_notification_count'
    end

    context 'given invalid params', vcr: { cassette_name: 'notification/get_notification_count_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_notification_count'
    end
  end

  describe '#reset_already_read_notification_count', vcr: { cassette_name: 'notification/reset_already_read_notification_count' } do
    let(:response) { client.reset_already_read_notification_count }
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

  describe '#mark_as_read_notification', vcr: { cassette_name: 'notification/mark_as_read_notification' } do
    let(:response) { client.mark_as_read_notification(3341549) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 204 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a response headers of no content'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of no content'
  end
end
