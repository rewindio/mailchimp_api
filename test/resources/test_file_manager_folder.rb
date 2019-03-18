# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::FileManagerFolder do
  BASE_FILE_MANAGER_FOLDER_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/file-manager/folders'
  FILE_MANAGER_FOLDER_ID = 1

  before do
    stub_request(:get, BASE_FILE_MANAGER_FOLDER_URL)
      .to_return body: load_fixture(:file_manager_folders)

    stub_request(:get, BASE_FILE_MANAGER_FOLDER_URL + "/#{FILE_MANAGER_FOLDER_ID}")
      .to_return body: load_fixture(:file_manager_folder)
  end

  it 'instantiates proper class' do
    file_manager_folders = MailchimpAPI::FileManagerFolder.all

    assert_kind_of MailchimpAPI::CollectionParsers::FileManagerFolder, file_manager_folders
    assert_instance_of MailchimpAPI::FileManagerFolder, file_manager_folders.first
  end

  describe 'countable' do
    it 'gets proper count' do
      stub_request(:get, BASE_FILE_MANAGER_FOLDER_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:file_manager_folders)

      assert_equal 2, MailchimpAPI::FileManagerFolder.count
    end
  end

  describe 'GET /file-manager/folders' do
    it 'fetches all file_manager_folders' do
      file_manager_folders = MailchimpAPI::FileManagerFolder.all

      assert_equal 2, file_manager_folders.count
      assert_equal 2, file_manager_folders.total_items
    end

    it 'file_manager_folders links are Links' do
      file_manager_folders = MailchimpAPI::FileManagerFolder.all

      assert_kind_of MailchimpAPI::Link, file_manager_folders.links.sample
    end
  end

  describe 'GET /file-manager/folders/:file_manager_folder_id' do
    it 'fetches specific file_manager_folder' do
      file_manager_folder = MailchimpAPI::FileManagerFolder.find FILE_MANAGER_FOLDER_ID

      assert_equal FILE_MANAGER_FOLDER_ID, file_manager_folder.id
      assert_empty file_manager_folder.prefix_options

      assert_respond_to file_manager_folder, :_links
      assert_kind_of MailchimpAPI::Link, file_manager_folder._links.sample
    end
  end

  describe 'update' do
    it 'calls PATCH /file-manager/folders/:file_manager_folder_id/' do
      stub_request(:patch, BASE_FILE_MANAGER_FOLDER_URL + "/#{FILE_MANAGER_FOLDER_ID}")
        .to_return status: 200

      file_manager_folder = MailchimpAPI::FileManagerFolder.find FILE_MANAGER_FOLDER_ID
      file_manager_folder.name = 'something else'
      file_manager_folder.save

      assert_not_requested :put, BASE_FILE_MANAGER_FOLDER_URL + "/#{FILE_MANAGER_FOLDER_ID}"
      assert_requested :patch, BASE_FILE_MANAGER_FOLDER_URL + "/#{FILE_MANAGER_FOLDER_ID}"
    end
  end
end
