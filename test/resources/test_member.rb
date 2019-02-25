# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Member do
  ALL_MEMBERS_URL    = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/members'
  SINGLE_MEMBER_URL  = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/members/m1234'
  MEMBER_ACTION_URL  = SINGLE_MEMBER_URL + '/actions'

  let(:members) { MailchimpAPI::Member.all params: { list_id: 'list1234' } }

  before do
    stub_request(:get, ALL_MEMBERS_URL)
      .to_return body: load_fixture(:members)

    stub_request(:get, SINGLE_MEMBER_URL)
      .to_return body: load_fixture(:member)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::Member, members
    assert_instance_of MailchimpAPI::Member, members.first
  end

  it 'raises an error with no list_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::Member.all
      end

    assert_match 'list_id prefix_option is missing', error.message
  end

  describe 'PATCH /members/:member_id' do
    let(:member) { MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' } }

    before do
      stub_request(:patch, SINGLE_MEMBER_URL)
        .to_return status: 200
    end

    it 'uses PATCH instead of PUT for an update' do
      member.language = 'English'
      member.save

      assert_not_requested :put, SINGLE_MEMBER_URL
      assert_requested :patch, SINGLE_MEMBER_URL
    end
  end

  describe 'notes' do
    it 'calls lists/:list_id/members/:member_id/notes with all IDs populated' do
      stub_request(:get, SINGLE_MEMBER_URL + '/notes')
        .to_return status: 200, body: load_fixture(:notes)

      member = MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' }
      member.notes

      assert_requested :get, SINGLE_MEMBER_URL + '/notes'
    end

    it 'uses provided params' do
      stub_request(:get, SINGLE_MEMBER_URL + '/notes?offset=123')
        .to_return status: 200, body: load_fixture(:notes)

      member = MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' }
      member.notes offset: 123

      assert_requested :get, SINGLE_MEMBER_URL + '/notes?offset=123'
    end
  end

  describe 'tags' do
    it 'calls lists/:list_id/members/:member_id/tags with all IDs populated' do
      stub_request(:get, SINGLE_MEMBER_URL + '/tags')
        .to_return status: 200, body: load_fixture(:tags)

      member = MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' }
      member.tags

      assert_requested :get, SINGLE_MEMBER_URL + '/tags'
    end

    it 'uses provided params' do
      stub_request(:get, SINGLE_MEMBER_URL + '/tags?offset=123')
        .to_return status: 200, body: load_fixture(:tags)

      member = MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' }
      member.tags offset: 123

      assert_requested :get, SINGLE_MEMBER_URL + '/tags?offset=123'
    end
  end

  describe 'POST /members/:member_id/actions/delete-permanent' do
    let(:member) { MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' } }

    before do
      stub_request(:post, MEMBER_ACTION_URL + '/delete-permanent')
        .to_return status: 204, body: nil
    end

    it 'permanently deletes a member ' do
      member.permanent_delete

      assert_requested :post, MEMBER_ACTION_URL + '/delete-permanent'
    end
  end

  describe 'update_tags' do
    let(:member) { MailchimpAPI::Member.find 'm1234', params: { list_id: 'list1234' } }

    before do
      stub_request(:post, SINGLE_MEMBER_URL + '/tags')
        .to_return status: 204, body: nil
    end

    it 'should send body as json' do
      member.update_tags [{ name: 'hi', status: 'active' }]

      assert_requested :post, SINGLE_MEMBER_URL + '/tags', body: '{"tags":[{"name":"hi","status":"active"}]}'
    end
  end
end
