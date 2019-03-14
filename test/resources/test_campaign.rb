# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Campaign do
  ALL_CAMPAIGNS_URL    = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/campaigns'
  SINGLE_CAMPAIGN_URL  = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/campaigns/c1234'
  CAMPAIGN_ACTION_URL  = SINGLE_CAMPAIGN_URL + '/actions'

  let(:campaign) { MailchimpAPI::Campaign.find 'c1234' }
  let(:campaigns) { MailchimpAPI::Campaign.all }

  before do
    stub_request(:get, ALL_CAMPAIGNS_URL)
      .to_return body: load_fixture(:campaigns)

    stub_request(:get, SINGLE_CAMPAIGN_URL)
      .to_return body: load_fixture(:campaign)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::Campaign, campaigns
    assert_instance_of MailchimpAPI::Campaign, campaigns.first
  end

  describe 'update' do
    before do
      stub_request(:patch, SINGLE_CAMPAIGN_URL)
        .to_return status: 200
    end

    it 'uses PATCH instead of PUT' do
      campaign.type = 'whatever'
      campaign.save

      assert_not_requested :put, SINGLE_CAMPAIGN_URL
      assert_requested :patch, SINGLE_CAMPAIGN_URL
    end
  end

  describe 'cancel_send' do
    it 'calls the cancel-send endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/cancel-send')
        .to_return status: 204

      campaign.cancel_send

      assert_requested :post, CAMPAIGN_ACTION_URL + '/cancel-send'
    end
  end

  describe 'create_resend' do
    it 'calls the create_resend endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/create-resend')
        .to_return status: 204

      campaign.create_resend

      assert_requested :post, CAMPAIGN_ACTION_URL + '/create-resend'
    end
  end

  describe 'pause' do
    it 'calls the pause endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/pause')
        .to_return status: 204

      campaign.pause

      assert_requested :post, CAMPAIGN_ACTION_URL + '/pause'
    end
  end

  describe 'replicate' do
    it 'calls the replicate endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/replicate')
        .to_return status: 200, body: load_fixture(:campaign)

      campaign.replicate

      assert_requested :post, CAMPAIGN_ACTION_URL + '/replicate'
    end
  end

  describe 'resume' do
    it 'calls the resume endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/resume')
        .to_return status: 204

      campaign.resume

      assert_requested :post, CAMPAIGN_ACTION_URL + '/resume'
    end
  end

  describe 'unschedule' do
    it 'calls the unschedule endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/unschedule')
        .to_return status: 204

      campaign.unschedule

      assert_requested :post, CAMPAIGN_ACTION_URL + '/unschedule'
    end
  end

  describe 'send_campaign' do
    it 'calls the send endpoint' do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/send')
        .to_return status: 204

      campaign.send_campaign

      assert_requested :post, CAMPAIGN_ACTION_URL + '/send'
    end
  end

  describe 'test' do
    before do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/test')
        .to_return status: 204
    end

    it 'calls the test endpoint' do
      campaign.test ['testy@example.com'], 'plaintext'

      assert_requested :post, CAMPAIGN_ACTION_URL + '/test', body: '{"test_emails":["testy@example.com"],"send_type":"plaintext"}'
    end

    it 'defaults to html content' do
      campaign.test ['testy@example.com']

      assert_requested :post, CAMPAIGN_ACTION_URL + '/test', body: '{"test_emails":["testy@example.com"],"send_type":"html"}'
    end

    it 'does nothing if no emails provided' do
      campaign.test

      assert_not_requested :post, CAMPAIGN_ACTION_URL + '/test'
    end
  end

  describe 'schedule' do
    before do
      stub_request(:post, CAMPAIGN_ACTION_URL + '/schedule')
        .to_return status: 204
    end

    it 'calls the schedule endpoint' do
      now = Time.now

      campaign.schedule now, true, true

      assert_requested :post, CAMPAIGN_ACTION_URL + '/schedule', body: "{\"schedule_time\":\"#{now.iso8601}\",\"timewarp\":true,\"batch_delivery\":true}"
    end

    it 'defaults timewarp and batch delivery to false' do
      now = Time.now

      campaign.schedule now

      assert_requested :post, CAMPAIGN_ACTION_URL + '/schedule', body: "{\"schedule_time\":\"#{now.iso8601}\",\"timewarp\":false,\"batch_delivery\":false}"
    end
  end
end
