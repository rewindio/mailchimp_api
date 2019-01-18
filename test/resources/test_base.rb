# frozen_string_literal: true

require 'test_helper'

module MailchimpAPI
  class TestBase < Test::Unit::TestCase
    def setup
      MailchimpAPI::Base.reset_session
    end

    def teardown
      MailchimpAPI::Base.reset_session
    end

    def test_initalized_headers
      assert_equal "MailchimpAPI/#{MailchimpAPI::VERSION}", MailchimpAPI::Base.headers['User-Agent']
      assert_equal 'application/json', MailchimpAPI::Base.headers['Accept']
      assert_equal 'OAuth ', MailchimpAPI::Base.headers['Authorization']
    end

    def test_activate_session
      assert_equal MailchimpAPI::Base.headers['Authorization'], 'OAuth '
      assert_equal MailchimpAPI::Base.site.to_s, MailchimpAPI.configuration.url

      session = MailchimpAPI::Session.new 'xxxyyyzzz-us3'

      MailchimpAPI::Base.activate_session session

      assert_equal MailchimpAPI::Base.headers['Authorization'], "OAuth #{session.oauth_token}"
      assert_match session.api_region_identifier, MailchimpAPI::Base.site.to_s
    end

    def test_reset_session
      session = MailchimpAPI::Session.new 'xxxyyyzzz-us3'

      MailchimpAPI::Base.activate_session session

      assert_equal MailchimpAPI::Base.headers['Authorization'], "OAuth #{session.oauth_token}"
      assert_match session.api_region_identifier, MailchimpAPI::Base.site.to_s

      MailchimpAPI::Base.reset_session

      assert_equal MailchimpAPI::Base.headers['Authorization'], 'OAuth '
      assert_equal MailchimpAPI::Base.site.to_s, MailchimpAPI.configuration.url
    end
  end
end
