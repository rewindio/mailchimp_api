# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CampaignFolder do
  BASE_CAMPAIGN_FOLDER_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/campaign-folders'
  CAMPAIGN_FOLDER_ID = 'cf1'

  before do
    stub_request(:get, BASE_CAMPAIGN_FOLDER_URL)
      .to_return body: load_fixture(:campaign_folders)

    stub_request(:get, BASE_CAMPAIGN_FOLDER_URL + "/#{CAMPAIGN_FOLDER_ID}")
      .to_return body: load_fixture(:campaign_folder)
  end

  it 'instantiates proper class' do
    campaign_folders = MailchimpAPI::CampaignFolder.all

    assert_kind_of MailchimpAPI::CollectionParsers::CampaignFolder, campaign_folders
    assert_instance_of MailchimpAPI::CampaignFolder, campaign_folders.first
  end

  describe 'countable' do
    it 'gets proper count' do
      stub_request(:get, BASE_CAMPAIGN_FOLDER_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:campaign_folders)

      assert_equal 1, MailchimpAPI::CampaignFolder.count
    end
  end

  describe 'GET /campaign-folders' do
    it 'fetches all campaign_folders' do
      campaign_folders = MailchimpAPI::CampaignFolder.all

      assert_equal 1, campaign_folders.count
      assert_equal 1, campaign_folders.total_items
    end

    it 'campaign_folders links are Links' do
      campaign_folders = MailchimpAPI::CampaignFolder.all

      assert_kind_of MailchimpAPI::Link, campaign_folders.links.sample
    end
  end

  describe 'GET /campaign-folders/:campaign_folder_id' do
    it 'fetches specific campaign_folder' do
      campaign_folder = MailchimpAPI::CampaignFolder.find CAMPAIGN_FOLDER_ID

      assert_equal CAMPAIGN_FOLDER_ID, campaign_folder.id
      assert_empty campaign_folder.prefix_options

      assert_respond_to campaign_folder, :_links
      assert_kind_of MailchimpAPI::Link, campaign_folder._links.sample
    end
  end

  describe 'update' do
    it 'calls PATCH /campaign-folders/:campaign_folder_id/' do
      stub_request(:patch, BASE_CAMPAIGN_FOLDER_URL + "/#{CAMPAIGN_FOLDER_ID}")
        .to_return status: 200

      campaign_folder = MailchimpAPI::CampaignFolder.find CAMPAIGN_FOLDER_ID
      campaign_folder.name = 'something else'
      campaign_folder.save

      assert_not_requested :put, BASE_CAMPAIGN_FOLDER_URL + "/#{CAMPAIGN_FOLDER_ID}"
      assert_requested :patch, BASE_CAMPAIGN_FOLDER_URL + "/#{CAMPAIGN_FOLDER_ID}"
    end
  end
end
