# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CollectionParsers::FileManagerFile do
  it 'element_key is files' do
    collection = MailchimpAPI::CollectionParsers::FileManagerFile.new

    assert_equal collection.send(:element_key), 'files'
  end
end
