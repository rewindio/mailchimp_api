# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::FileManagerFile do
  BASE_FILE_MANAGER_FILE_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/file-manager/files'
  FILE_MANAGER_FILE_ID = 1

  before do
    stub_request(:get, BASE_FILE_MANAGER_FILE_URL)
      .to_return body: load_fixture(:file_manager_files)

    stub_request(:get, BASE_FILE_MANAGER_FILE_URL + "/#{FILE_MANAGER_FILE_ID}")
      .to_return body: load_fixture(:file_manager_file)
  end

  it 'instantiates proper class' do
    file_manager_files = MailchimpAPI::FileManagerFile.all

    assert_kind_of MailchimpAPI::CollectionParsers::FileManagerFile, file_manager_files
    assert_instance_of MailchimpAPI::FileManagerFile, file_manager_files.first
  end

  describe 'update' do
    it 'calls PATCH /file-manager/files/:file_manager_FILE_id/' do
      stub_request(:patch, BASE_FILE_MANAGER_FILE_URL + "/#{FILE_MANAGER_FILE_ID}")
        .to_return status: 200

      file_manager_file = MailchimpAPI::FileManagerFile.find FILE_MANAGER_FILE_ID
      file_manager_file.name = 'something else'
      file_manager_file.save

      assert_not_requested :put, BASE_FILE_MANAGER_FILE_URL + "/#{FILE_MANAGER_FILE_ID}"
      assert_requested :patch, BASE_FILE_MANAGER_FILE_URL + "/#{FILE_MANAGER_FILE_ID}"
    end
  end
end
