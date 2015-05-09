require 'spec_helper'

describe BacklogKit::Client::Group do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_groups' do
    shared_examples_for 'a response body of #get_groups' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:group) { response.body[0] }
          it_behaves_like 'a resource of group', member: true
        end
      end
    end

    let(:response) { client.get_groups(request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'group/get_groups_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_groups'
    end

    context 'given valid params', vcr: { cassette_name: 'group/get_groups_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_groups'
    end

    context 'given invalid params', vcr: { cassette_name: 'group/get_groups_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_groups'
    end
  end

  describe '#get_group', vcr: { cassette_name: 'group/get_group' } do
    let(:response) { client.get_group(3089) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:group) { response.body }
      it_behaves_like 'a resource of group', member: true
    end
  end

  shared_examples_for 'a response body of group' do |flags|
    describe '#body' do
      let(:group) { response.body }
      it_behaves_like 'a resource of group', flags
    end
  end

  describe '#create_group' do
    let(:response) { client.create_group(name, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'group/create_group_given_no_params' } do
      let(:name) { 'テストグループ1' }
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of group', member: false
    end

    context 'given valid params', vcr: { cassette_name: 'group/create_group_given_valid_params' } do
      let(:name) { 'テストグループ2' }
      let(:request_params) { { members: [47893, 56534] } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of group', member: true
    end

    context 'given invalid params', vcr: { cassette_name: 'group/create_group_given_invalid_params' } do
      let(:name) { 'テストグループ3' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_group' do
    let(:response) { client.update_group(3747, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'group/update_group_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of group', member: false
    end

    context 'given valid params', vcr: { cassette_name: 'group/update_group_given_valid_params' } do
      let(:request_params) { { name: 'テストグループ4' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of group', member: false
    end

    context 'given invalid params', vcr: { cassette_name: 'group/update_group_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#delete_group', vcr: { cassette_name: 'group/delete_group' } do
    let(:response) { client.delete_group(3747) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'
    it_behaves_like 'a response body of group', member: false
  end
end
