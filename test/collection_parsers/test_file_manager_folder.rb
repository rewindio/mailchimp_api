# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CollectionParsers::FileManagerFolder do
  it 'element_key is folders' do
    collection = MailchimpAPI::CollectionParsers::FileManagerFolder.new

    assert_equal collection.send(:element_key), 'folders'
  end
end
