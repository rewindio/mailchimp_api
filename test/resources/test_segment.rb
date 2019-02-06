# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Segment do
  ALL_SEGMENTS_URL    = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/segments'
  SINGLE_SEGMENT_URL  = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/segments/1234'

  let(:segments) { MailchimpAPI::Segment.all params: { list_id: 'list1234' } }

  before do
    stub_request(:get, ALL_SEGMENTS_URL)
      .to_return body: load_fixture(:segments)

    stub_request(:get, SINGLE_SEGMENT_URL)
      .to_return body: load_fixture(:segment)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::Segment, segments
    assert_instance_of MailchimpAPI::Segment, segments.first
  end

  it 'raises an error with no list_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::Segment.all
      end

    assert_match 'list_id prefix_option is missing', error.message
  end

  describe 'PATCH /segments/:segment_id' do
    let(:segment) { MailchimpAPI::Segment.find '1234', params: { list_id: 'list1234' } }

    before do
      stub_request(:patch, SINGLE_SEGMENT_URL)
        .to_return status: 200
    end

    it 'uses PATCH instead of PUT for an update' do
      segment.language = 'Januaries'
      segment.save

      assert_not_requested :put, SINGLE_SEGMENT_URL
      assert_requested :patch, SINGLE_SEGMENT_URL
    end
  end
end
