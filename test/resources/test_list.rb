# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::List do
  BASE_LIST_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists'

  before do
    stub_request(:get, BASE_LIST_URL)
      .to_return body: load_fixture(:lists)
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
      list_id = '6574d0bcc7'

      stub_request(:get, BASE_LIST_URL + "/#{list_id}")
        .to_return body: load_fixture(:list)

      list = MailchimpAPI::List.find list_id

      assert_equal list_id, list.id
      assert_empty list.prefix_options

      assert_respond_to list, :_links
      assert_kind_of MailchimpAPI::Link, list._links.sample
    end
  end
end
