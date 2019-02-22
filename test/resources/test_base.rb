# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Base do
  before do
    MailchimpAPI::Base.reset_session
  end

  after do
    MailchimpAPI::Base.reset_session
  end

  it 'properly initializes the headers' do
    assert_equal "MailchimpAPI/#{MailchimpAPI::VERSION}", MailchimpAPI::Base.headers['User-Agent']
    assert_equal 'application/json', MailchimpAPI::Base.headers['Accept']
    assert_equal 'OAuth ', MailchimpAPI::Base.headers['Authorization']
  end

  it 'actives a session' do
    assert_equal MailchimpAPI::Base.headers['Authorization'], 'OAuth '
    assert_equal MailchimpAPI::Base.site.to_s, MailchimpAPI.configuration.url

    session = MailchimpAPI::Session.new 'xxxyyyzzz-us3'

    MailchimpAPI::Base.activate_session session

    assert_equal MailchimpAPI::Base.headers['Authorization'], "OAuth #{session.oauth_token}"
    assert_match session.api_region_identifier, MailchimpAPI::Base.site.to_s
  end

  it 'resets a session' do
    session = MailchimpAPI::Session.new 'xxxyyyzzz-us3'

    MailchimpAPI::Base.activate_session session

    assert_equal MailchimpAPI::Base.headers['Authorization'], "OAuth #{session.oauth_token}"
    assert_match session.api_region_identifier, MailchimpAPI::Base.site.to_s

    MailchimpAPI::Base.reset_session

    assert_equal MailchimpAPI::Base.headers['Authorization'], 'OAuth '
    assert_equal MailchimpAPI::Base.site.to_s, MailchimpAPI.configuration.url
  end

  describe 'exists' do
    it 'returns false if item not found' do
      stub_request(:get, 'https://__api_region_identifier__.api.mailchimp.com/3.0/bases/123')
        .to_return status: 404

      assert_equal false, MailchimpAPI::Base.exists?(123)
    end

    it 'returns true if item found' do
      stub_request(:get, 'https://__api_region_identifier__.api.mailchimp.com/3.0/bases/123')
        .to_return status: 200, body: '{}'

      assert_equal true, MailchimpAPI::Base.exists?(123)
    end
  end
end
