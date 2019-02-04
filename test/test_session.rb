# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Session do
  let(:oauth_token) { 'xxxyyyzzz-us7' }

  it 'successfully_initialize' do
    session = MailchimpAPI::Session.new oauth_token

    assert_equal oauth_token, session.oauth_token
    assert_equal 'us7', session.api_region_identifier
  end

  it 'temp_cleanup' do
    assert_equal MailchimpAPI::Base.headers['Authorization'], 'OAuth '
    assert_equal MailchimpAPI::Base.site.to_s, MailchimpAPI.configuration.url

    MailchimpAPI::Session.temp(oauth_token) do
      assert_equal MailchimpAPI::Base.headers['Authorization'], "OAuth #{oauth_token}"
    end

    assert_equal MailchimpAPI::Base.headers['Authorization'], 'OAuth '
    assert_equal MailchimpAPI::Base.site.to_s, MailchimpAPI.configuration.url
  end
end
