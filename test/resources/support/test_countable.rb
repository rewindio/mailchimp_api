# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Support::Countable do
  before do
    stub_request(:get, 'https://__api_region_identifier__.api.mailchimp.com/3.0/lists?count=0&fields=total_items')
      .to_return body: load_fixture(:count_payload)
  end

  it 'successfully gets a count' do
    assert_equal 2, MailchimpAPI::List.count
  end
end
