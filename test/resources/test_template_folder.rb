# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::TemplateFolder do
  BASE_TEMPLATE_FOLDER_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/template-folders'
  TEMPLATE_FOLDER_ID = '715527e6c4'

  before do
    stub_request(:get, BASE_TEMPLATE_FOLDER_URL)
      .to_return body: load_fixture(:template_folders)

    stub_request(:get, BASE_TEMPLATE_FOLDER_URL + "/#{TEMPLATE_FOLDER_ID}")
      .to_return body: load_fixture(:template_folder)
  end

  it 'instantiates proper class' do
    template_folders = MailchimpAPI::TemplateFolder.all

    assert_kind_of MailchimpAPI::CollectionParsers::TemplateFolder, template_folders
    assert_instance_of MailchimpAPI::TemplateFolder, template_folders.first
  end

  describe 'countable' do
    it 'gets proper count' do
      stub_request(:get, BASE_TEMPLATE_FOLDER_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:template_folders)

      assert_equal 3, MailchimpAPI::TemplateFolder.count
    end
  end

  describe 'GET /template-folders' do
    it 'fetches all template_folders' do
      template_folders = MailchimpAPI::TemplateFolder.all

      assert_equal 3, template_folders.count
      assert_equal 3, template_folders.total_items
    end

    it 'template_folders links are Links' do
      template_folders = MailchimpAPI::TemplateFolder.all

      assert_kind_of MailchimpAPI::Link, template_folders.links.sample
    end
  end

  describe 'GET /template-folders/:template_folder_id' do
    it 'fetches specific template_folder' do
      template_folder = MailchimpAPI::TemplateFolder.find TEMPLATE_FOLDER_ID

      assert_equal TEMPLATE_FOLDER_ID, template_folder.id
      assert_empty template_folder.prefix_options

      assert_respond_to template_folder, :_links
      assert_kind_of MailchimpAPI::Link, template_folder._links.sample
    end
  end

  describe 'update' do
    it 'calls PATCH /template-folders/:template_folder_id/' do
      stub_request(:patch, BASE_TEMPLATE_FOLDER_URL + "/#{TEMPLATE_FOLDER_ID}")
        .to_return status: 200

      template_folder = MailchimpAPI::TemplateFolder.find TEMPLATE_FOLDER_ID
      template_folder.name = 'something else'
      template_folder.save

      assert_not_requested :put, BASE_TEMPLATE_FOLDER_URL + "/#{TEMPLATE_FOLDER_ID}"
      assert_requested :patch, BASE_TEMPLATE_FOLDER_URL + "/#{TEMPLATE_FOLDER_ID}"
    end
  end
end
