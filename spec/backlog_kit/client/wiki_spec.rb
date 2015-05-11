require 'spec_helper'

describe BacklogKit::Client::Wiki do
  let(:client) do
    BacklogKit::Client.new(space_id: ENV['BACKLOG_SPACE_ID'], api_key: ENV['BACKLOG_API_KEY'])
  end

  describe '#get_wikis', vcr: { cassette_name: 'wiki/get_wikis' } do
    let(:response) { client.get_wikis(31224) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[1]' do
        let(:wiki) { response.body[1] }
        it_behaves_like 'a resource of wiki'
      end
    end
  end

  describe '#get_wiki_count', vcr: { cassette_name: 'wiki/get_wiki_count' } do
    let(:response) { client.get_wiki_count(31224) }
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

  describe '#get_wiki', vcr: { cassette_name: 'wiki/get_wiki' } do
    let(:response) { client.get_wiki(80179) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      let(:wiki) { response.body }
      it_behaves_like 'a resource of wiki'
    end
  end

  describe '#get_wiki_tags', vcr: { cassette_name: 'wiki/get_wiki_tags' } do
    let(:response) { client.get_wiki_tags(31224) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:tag) { response.body[0] }
        it_behaves_like 'a resource of tag'
      end
    end
  end

  shared_examples_for 'a response body of wiki' do
    describe '#body' do
      let(:wiki) { response.body }
      it_behaves_like 'a resource of wiki'
    end
  end

  describe '#create_wiki' do
    let(:response) { client.create_wiki(name, content, 31224, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 201 }

    context 'given no params', vcr: { cassette_name: 'wiki/create_wiki_given_no_params' } do
      let(:name) { '[テストタグ1] テストウィキ1' }
      let(:content) { 'テストウィキ1の内容です。' }
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of wiki'
    end

    context 'given valid params', vcr: { cassette_name: 'wiki/create_wiki_given_valid_params' } do
      let(:name) { '[テストタグ1] テストウィキ2' }
      let(:content) { 'テストウィキ2の内容です。' }
      let(:request_params) { { mail_notify: false } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of wiki'
    end

    context 'given invalid params', vcr: { cassette_name: 'wiki/create_wiki_given_invalid_params' } do
      let(:name) { '[テストタグ1] テストウィキ3' }
      let(:content) { 'テストウィキ3の内容です。' }
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#update_wiki' do
    let(:response) { client.update_wiki(80588, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given name only', vcr: { cassette_name: 'wiki/update_wiki_given_name_only' } do
      let(:request_params) { { name: '[テストタグ2] テストウィキ4' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of wiki'
    end

    context 'given valid params', vcr: { cassette_name: 'wiki/update_wiki_given_valid_params' } do
      let(:request_params) { { name: '[テストタグ2] テストウィキ5', content: 'テストウィキ5の内容です。' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of wiki'
    end

    context 'given invalid params', vcr: { cassette_name: 'wiki/update_wiki_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:request_params) { { invalid_param_key.to_sym => 'test' } }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#delete_wiki' do
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'wiki/delete_wiki_given_no_params' } do
      let(:response) { client.delete_wiki(80588) }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of wiki'
    end

    context 'given valid params', vcr: { cassette_name: 'wiki/delete_wiki_given_valid_params' } do
      let(:response) { client.delete_wiki(80589, { mail_notify: false }) }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of wiki'
    end

    context 'given invalid params', vcr: { cassette_name: 'wiki/delete_wiki_given_invalid_params' } do
      let(:invalid_param_key) { 'test' }
      let(:response) { client.delete_wiki(80179, { invalid_param_key.to_sym => 'test' }) }

      it_behaves_like 'a invalid request error'
    end
  end

  describe '#get_wiki_shared_files', vcr: { cassette_name: 'wiki/get_wiki_shared_files' } do
    let(:response) { client.get_wiki_shared_files(80179) }
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

  describe '#link_wiki_shared_files', vcr: { cassette_name: 'wiki/link_wiki_shared_files' } do
    let(:response) { client.link_wiki_shared_files(80242, [2654538]) }
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

  describe '#unlink_wiki_shared_file', vcr: { cassette_name: 'wiki/unlink_wiki_shared_file' } do
    let(:response) { client.unlink_wiki_shared_file(80242, 2654538) }
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

  describe '#get_wiki_histories' do
    shared_examples_for 'a response body of #get_wiki_histories' do
      describe '#body' do
        subject { response.body }
        it { is_expected.to be_a Array }

        describe '#[0]' do
          let(:history) { response.body[0] }
          it_behaves_like 'a resource of history'
        end
      end
    end

    let(:response) { client.get_wiki_histories(80179, request_params) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    context 'given no params', vcr: { cassette_name: 'wiki/get_wiki_histories_given_no_params' } do
      let(:request_params) { {} }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_wiki_histories'
    end

    context 'given valid params', vcr: { cassette_name: 'wiki/get_wiki_histories_given_valid_params' } do
      let(:request_params) { { order: 'asc' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_wiki_histories'
    end

    context 'given invalid params', vcr: { cassette_name: 'wiki/get_wiki_histories_given_invalid_params' } do
      let(:request_params) { { test: 'test' } }

      it_behaves_like 'a normal response'
      it_behaves_like 'a normal response headers'
      it_behaves_like 'a normal response status'
      it_behaves_like 'a response body of #get_wiki_histories'
    end
  end

  describe '#get_wiki_stars', vcr: { cassette_name: 'wiki/get_wiki_stars' } do
    let(:response) { client.get_wiki_stars(80179) }
    let(:content_type) { 'application/json; charset=utf-8' }
    let(:status_code) { 200 }

    it_behaves_like 'a normal response'
    it_behaves_like 'a normal response headers'
    it_behaves_like 'a normal response status'

    describe '#body' do
      subject { response.body }
      it { is_expected.to be_a Array }

      describe '#[0]' do
        let(:star) { response.body[0] }
        it_behaves_like 'a resource of star'
      end
    end
  end
end
