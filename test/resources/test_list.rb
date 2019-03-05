# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::List do
  BASE_LIST_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists'
  LIST_ID = '6574d0bcc7'

  before do
    stub_request(:get, BASE_LIST_URL)
      .to_return body: load_fixture(:lists)

    stub_request(:get, BASE_LIST_URL + "/#{LIST_ID}")
      .to_return body: load_fixture(:list)
  end

  it 'instantiates proper class' do
    lists = MailchimpAPI::List.all

    assert_kind_of MailchimpAPI::CollectionParsers::List, lists
    assert_instance_of MailchimpAPI::List, lists.first
  end

  describe 'countable' do
    it 'gets proper count' do
      stub_request(:get, BASE_LIST_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::List.count
    end
  end

  describe 'GET /lists' do
    it 'fetches all lists' do
      lists = MailchimpAPI::List.all

      assert_equal 2, lists.count
      assert_equal 2, lists.total_items
    end

    it 'lists links are Links' do
      lists = MailchimpAPI::List.all

      assert_kind_of MailchimpAPI::Link, lists.links.sample
    end
  end

  describe 'GET /links/:link_id' do
    it 'fetches specific list' do
      list = MailchimpAPI::List.find LIST_ID

      assert_equal LIST_ID, list.id
      assert_empty list.prefix_options

      assert_respond_to list, :_links
      assert_kind_of MailchimpAPI::Link, list._links.sample
    end
  end

  describe 'update' do
    it 'calls PATCH /lists/:list_id/' do
      stub_request(:patch, BASE_LIST_URL + "/#{LIST_ID}")
        .to_return status: 200

      list = MailchimpAPI::List.find LIST_ID
      list.permission_reminder = 'something else'
      list.save

      assert_not_requested :put, BASE_LIST_URL + "/#{LIST_ID}"
      assert_requested :patch, BASE_LIST_URL + "/#{LIST_ID}"
    end
  end
end
