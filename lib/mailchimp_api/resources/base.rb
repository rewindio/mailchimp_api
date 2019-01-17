# frozen_string_literal: true

module MailchimpAPI
  class Base < ActiveResource::Base
    # self.headers['X-Auth-Client'] = MailchimpAPI.configuration.client_id
    headers['User-Agent'] = "MailchimpAPI/#{MailchimpAPI::VERSION}"
    headers['Accept'] = 'application/json'
    headers['Authorization'] = 'OAuth '

    self.site = MailchimpAPI.configuration.url

    self.include_format_in_path = false

    self.format = MailchimpAPI::JsonFormatter.new :result

    has_many :_links, class_name: 'MailchimpAPI::Link'

    class << self
      def activate_session(session)
        self.headers['Authorization'] = "OAuth #{session.oauth_token}" # rubocop:disable Style/RedundantSelf

        MailchimpAPI::Base.site = MailchimpAPI.configuration.url.sub '__API_REGION_IDENTIFIER__', session.api_region_identifier
      end

      def reset_session
        self.headers['Authorization'] = 'OAuth ' # rubocop:disable Style/RedundantSelf

        MailchimpAPI::Base.site = MailchimpAPI.configuration.url
      end

      def headers
        if _headers_defined?
          _headers
        elsif superclass != Object && superclass.headers
          superclass.headers
        else
          _headers || {}
        end
      end
    end

    def to_h
      JSON.parse(attributes.to_json).symbolize_keys
    end
  end
end