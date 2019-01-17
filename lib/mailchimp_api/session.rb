# frozen_string_literal: true

module MailchimpAPI
  class Session
    attr_accessor :oauth_token, :api_region_identifier

    def initialize(oauth_token)
      self.oauth_token            = oauth_token
      self.api_region_identifier  = oauth_token&.split('-')&.last || '__API_REGION_IDENTIFIER__'
    end

    class << self
      def temp(oauth_token)
        session = new oauth_token

        MailchimpAPI::Base.activate_session session

        yield
      ensure
        MailchimpAPI::Base.reset_session
      end
    end
  end
end
