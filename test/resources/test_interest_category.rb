# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::InterestCategory do
  ALL_INTEREST_CATEGORIES_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/interest-categories'
  SINGLE_INTEREST_CATEGORY_URL = ALL_INTEREST_CATEGORIES_URL + '/ic1234'

  before do
    stub_request(:get, ALL_INTEREST_CATEGORIES_URL)
      .to_return body: load_fixture(:interest_categories)

    stub_request(:get, SINGLE_INTEREST_CATEGORY_URL)
      .to_return body: load_fixture(:interest_category)
  end

  it 'instantiates proper class' do
    interest_categories = MailchimpAPI::InterestCategory.all params: { list_id: 'list1234' }

    assert_kind_of MailchimpAPI::CollectionParsers::InterestCategory, interest_categories
    assert_instance_of MailchimpAPI::InterestCategory, interest_categories.first
  end

  it 'requires list_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::InterestCategory.all
    end

    assert_match 'list_id prefix_option is missing', error.message
  end

  describe 'countable' do
    it 'test_countable' do
      stub_request(:get, ALL_INTEREST_CATEGORIES_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::InterestCategory.count(params: { list_id: 'list1234' })
    end
  end

  describe 'interests' do
    it 'calls lists/:list_id/interest-categories/:interest_category_id/interests with all IDs populated' do
      stub_request(:get, SINGLE_INTEREST_CATEGORY_URL + '/interests')
        .to_return status: 200, body: load_fixture(:interests)

      interest_category = MailchimpAPI::InterestCategory.find 'ic1234', params: { list_id: 'list1234' }
      interest_category.interests

      assert_requested :get, SINGLE_INTEREST_CATEGORY_URL + '/interests'
    end

    it 'uses provided params' do
      stub_request(:get, SINGLE_INTEREST_CATEGORY_URL + '/interests?offset=123')
        .to_return status: 200, body: load_fixture(:interests)

      interest_category = MailchimpAPI::InterestCategory.find 'ic1234', params: { list_id: 'list1234' }
      interest_category.interests offset: 123

      assert_requested :get, SINGLE_INTEREST_CATEGORY_URL + '/interests?offset=123'
    end
  end

  describe 'update' do
    it 'calls PATCH /interest-categories/:interest_category_id' do
      stub_request(:patch, SINGLE_INTEREST_CATEGORY_URL)
        .to_return status: 200

      interest_category = MailchimpAPI::InterestCategory.find 'ic1234', params: { list_id: 'list1234' }
      interest_category.type = 'something else'
      interest_category.save

      assert_not_requested :put, SINGLE_INTEREST_CATEGORY_URL
      assert_requested :patch, SINGLE_INTEREST_CATEGORY_URL
    end
  end
end
