# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Tag do
  ALL_TAGS_URL    = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/members/member1234/tags'

  let(:tags) { MailchimpAPI::Tag.all params: { list_id: 'list1234', member_id: 'member1234' } }

  before do
    stub_request(:get, ALL_TAGS_URL)
      .to_return body: load_fixture(:tags)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::Tag, tags
    assert_instance_of MailchimpAPI::Tag, tags.first
  end

  it 'raises an error with no list_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::Tag.all
      end

    assert_match 'list_id prefix_option is missing', error.message
  end

  it 'raises an error with no member_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::Tag.all params: { list_id: 'list1234' }
      end

    assert_match 'member_id prefix_option is missing', error.message
  end
end
