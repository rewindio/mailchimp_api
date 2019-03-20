# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CampaignContent do
  CAMPAIGN_ID = 'c1234'

  SINGLE_CAMPAIGN_CONTENT_URL = "https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/campaigns/#{CAMPAIGN_ID}/content"

  before do
    stub_request(:get, SINGLE_CAMPAIGN_CONTENT_URL)
      .to_return body: load_fixture(:campaign_content)
  end

  describe 'instantiates a single record regardless of the request type' do
    it '.all' do
      campaign_content = MailchimpAPI::CampaignContent.all params: { campaign_id: CAMPAIGN_ID }

      assert_instance_of MailchimpAPI::CampaignContent, campaign_content
    end

    it '.first' do
      campaign_content = MailchimpAPI::CampaignContent.first params: { campaign_id: CAMPAIGN_ID }

      assert_instance_of MailchimpAPI::CampaignContent, campaign_content
    end

    it '.last' do
      campaign_content = MailchimpAPI::CampaignContent.last params: { campaign_id: CAMPAIGN_ID }

      assert_instance_of MailchimpAPI::CampaignContent, campaign_content
    end

    it '.find' do
      campaign_content = MailchimpAPI::CampaignContent.find 'fake_id', params: { campaign_id: CAMPAIGN_ID }

      assert_instance_of MailchimpAPI::CampaignContent, campaign_content
    end

    it '.find :all' do
      campaign_content = MailchimpAPI::CampaignContent.find :all, params: { campaign_id: CAMPAIGN_ID }

      assert_instance_of MailchimpAPI::CampaignContent, campaign_content
    end
  end
end
