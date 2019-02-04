# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CollectionParsers::InterestCategory do
  it 'element_key is categories' do
    collection = MailchimpAPI::CollectionParsers::InterestCategory.new

    assert_equal collection.send(:element_key), 'categories'
  end
end
