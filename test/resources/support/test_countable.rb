# frozen_string_literal: true

require 'test_helper'

module MailchimpAPI::Support
  class TestCountable < Test::Unit::TestCase
    def setup
      super

      stub_request(:get, 'https://__api_region_identifier__.api.mailchimp.com/3.0/lists?count=0&fields=total_items')
        .to_return body: { total_items: 2 }.to_json
    end

    def test_successful_count
      assert_equal 2, MailchimpAPI::List.count
    end
  end
end
