# frozen_string_literal: true

require 'test_helper'

module MailchimpAPI
  class TestList < Test::Unit::TestCase
    BASE_LIST_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists'

    def setup
      super

      stub_request(:get, BASE_LIST_URL)
        .to_return body: load_fixture(:lists)
    end

    def test_countable
      stub_request(:get, BASE_LIST_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::List.count
    end

    def test_instantiates_proper_class
      lists = MailchimpAPI::List.all

      assert_kind_of MailchimpAPI::CollectionParsers::List, lists
      assert_instance_of MailchimpAPI::List, lists.first
    end

    def test_fetches_all_lists
      lists = MailchimpAPI::List.all

      assert_equal 2, lists.count
      assert_equal 2, lists.total_items
    end

    def test_lists_has_valid_links
      lists = MailchimpAPI::List.all

      assert_kind_of MailchimpAPI::Link, lists.links.sample
    end

    def test_fetches_specific_list
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
