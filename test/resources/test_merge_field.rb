# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::MergeField do
  ALL_MERGE_FIELDS_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/merge-fields'
  SINGLE_MERGE_FIELD_URL = ALL_MERGE_FIELDS_URL + '/1'

  let(:merge_fields) { MailchimpAPI::MergeField.all params: { list_id: 'list1234' } }

  before do
    stub_request(:get, ALL_MERGE_FIELDS_URL)
      .to_return body: load_fixture(:merge_fields)

    stub_request(:get, SINGLE_MERGE_FIELD_URL)
      .to_return body: load_fixture(:merge_field)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::MergeField, merge_fields
    assert_instance_of MailchimpAPI::MergeField, merge_fields.first
  end

  it 'raises an error with no list_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::MergeField.all
      end

    assert_match 'list_id prefix_option is missing', error.message
  end

  describe 'PATCH /merge-fields/:merge_field_id' do
    let(:merge_field) { MailchimpAPI::MergeField.find 1, params: { list_id: 'list1234' } }

    before do
      stub_request(:patch, SINGLE_MERGE_FIELD_URL)
        .to_return status: 200
    end

    it 'uses PATCH instead of PUT for an update' do
      merge_field.required = true
      merge_field.save

      assert_not_requested :put, SINGLE_MERGE_FIELD_URL
      assert_requested :patch, SINGLE_MERGE_FIELD_URL
    end
  end

  describe 'GET /lists/{list_id}/merge-fields' do
    let(:merge_fields) { MailchimpAPI::MergeField.all params: { list_id: 'list1234' } }

    it 'fetches all merge fields' do
      assert_equal 5, merge_fields.count
      assert_equal 5, merge_fields.total_items
    end
  end

  describe 'countable' do
    it 'gets proper count' do
      stub_request(:get, ALL_MERGE_FIELDS_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::MergeField.count(params: { list_id: 'list1234' })
    end
  end

  # create
  describe 'POST /merge-fields' do
    before do
      stub_request(:post, ALL_MERGE_FIELDS_URL)
        .to_return status: 200, body: nil
    end

    it 'creates a new merge field' do
      merge_field = MailchimpAPI::MergeField.new params: { name: 'test', type: 'text' }
      merge_field.prefix_options[:list_id] = 'list1234'

      merge_field.save!

      assert_requested :post, ALL_MERGE_FIELDS_URL
    end
  end
end
