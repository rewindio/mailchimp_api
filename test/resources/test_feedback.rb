# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Feedback do
  ALL_FEEDBACK_URL     = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/campaigns/c1234/feedback'
  SINGLE_FEEDBACK_URL  = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/campaigns/c1234/feedback/1'

  let(:feedbacks) { MailchimpAPI::Feedback.all params: { campaign_id: 'c1234' } }

  before do
    stub_request(:get, ALL_FEEDBACK_URL)
      .to_return body: load_fixture(:feedbacks)

    stub_request(:get, SINGLE_FEEDBACK_URL)
      .to_return body: load_fixture(:feedback)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::Feedback, feedbacks
    assert_instance_of MailchimpAPI::Feedback, feedbacks.first
  end

  it 'raises an error with no campaign_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::Feedback.all
      end

    assert_match 'campaign_id prefix_option is missing', error.message
  end

  describe 'update' do
    let(:feedback) { MailchimpAPI::Feedback.find 1, params: { campaign_id: 'c1234' } }

    before do
      stub_request(:patch, SINGLE_FEEDBACK_URL)
        .to_return status: 200
    end

    it 'uses PATCH instead of PUT' do
      feedback.message = 'No thanks'
      feedback.save

      assert_not_requested :put, SINGLE_FEEDBACK_URL
      assert_requested :patch, SINGLE_FEEDBACK_URL
    end
  end
end
