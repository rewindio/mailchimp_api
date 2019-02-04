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

  it 'raises an error with no list_io prefix_option' do
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
end
