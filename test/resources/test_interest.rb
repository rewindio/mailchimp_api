# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Interest do
  ALL_INTERESTS_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/interest-categories/ic1234/interests'
  SINGLE_INTEREST_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/interest-categories/ic1234/interests/i1234'

  before do
    stub_request(:get, ALL_INTERESTS_URL)
      .to_return body: load_fixture(:interests)

    stub_request(:get, SINGLE_INTEREST_URL)
      .to_return body: load_fixture(:interest)
  end

  it 'instantiates proper class' do
    interests = MailchimpAPI::Interest.all params: { list_id: 'list1234', interest_category_id: 'ic1234' }

    assert_kind_of MailchimpAPI::CollectionParsers::Interest, interests
    assert_instance_of MailchimpAPI::Interest, interests.first
  end

  it 'requires list_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::Interest.all
    end

    assert_match 'list_id prefix_option is missing', error.message
  end

  it 'requires interest_category_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::Interest.all params: { list_id: 'list1234' }
    end

    assert_match 'interest_category_id prefix_option is missing', error.message
  end

  describe 'countable' do
    it 'test_countable' do
      stub_request(:get, ALL_INTERESTS_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::Interest.count(params: { list_id: 'list1234', interest_category_id: 'ic1234' })
    end
  end

  describe 'update' do
    it 'calls PATCH /interest-categories/:interest_category_id/interests' do
      stub_request(:patch, SINGLE_INTEREST_URL)
        .to_return status: 200

      interest = MailchimpAPI::Interest.find 'i1234', params: { list_id: 'list1234', interest_category_id: 'ic1234' }
      interest.name = 'something else'
      interest.save

      assert_not_requested :put, SINGLE_INTEREST_URL
      assert_requested :patch, SINGLE_INTEREST_URL
    end
  end
end
