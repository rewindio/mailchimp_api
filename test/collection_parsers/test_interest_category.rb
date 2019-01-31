# frozen_string_literal: true

require 'test_helper'

module MailchimpAPI::CollectionParsers
  class TestBase < Test::Unit::TestCase
    def test_element_key_is_categories
      collection = MailchimpAPI::CollectionParsers::InterestCategory.new

      assert_equal collection.send(:element_key), 'categories'
    end
  end
end
