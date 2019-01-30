# frozen_string_literal: true

require 'test_helper'

module MailchimpAPI
  class TestInterestCategory < Test::Unit::TestCase
    ALL_INTEREST_CATEGORIES_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/interest-categories'
    SINGLE_INTEREST_CATEGORY_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/interest-categories/ic1234'

    def setup
      super

      stub_request(:get, ALL_INTEREST_CATEGORIES_URL)
        .to_return body: load_fixture(:interest_categories)

      stub_request(:get, SINGLE_INTEREST_CATEGORY_URL)
        .to_return body: load_fixture(:interest_category)
    end

    def test_requires_list_id_prefix
      error = assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::InterestCategory.all
      end

      assert_match 'list_id prefix_option is missing', error.message
    end

    def test_update_uses_patch_request
      stub_request(:patch, SINGLE_INTEREST_CATEGORY_URL)
        .to_return status: 200

      interest_category = MailchimpAPI::InterestCategory.find 'ic1234', params: { list_id: 'list1234' }
      interest_category.type = 'something else'
      interest_category.save

      assert_not_requested :put, SINGLE_INTEREST_CATEGORY_URL
      assert_requested :patch, SINGLE_INTEREST_CATEGORY_URL
    end

    def test_countable
      stub_request(:get, ALL_INTEREST_CATEGORIES_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::InterestCategory.count(params: { list_id: 'list1234' })
    end

    def test_instantiates_proper_class
      interest_categories = MailchimpAPI::InterestCategory.all params: { list_id: 'list1234' }

      assert_kind_of MailchimpAPI::CollectionParsers::InterestCategory, interest_categories
      assert_instance_of MailchimpAPI::InterestCategory, interest_categories.first
    end
  end
end
