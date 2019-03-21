# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CollectionParsers::Feedback do
  it 'element_key is feedback' do
    collection = MailchimpAPI::CollectionParsers::Feedback.new

    assert_equal collection.send(:element_key), 'feedback'
  end
end
