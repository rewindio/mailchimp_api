# frozen_string_literal: true

module MailchimpAPI
  class Configuration
    DEFAULT_API_REGION_IDENTIFIER = '__API_REGION_IDENTIFIER__'

    attr_accessor :url

    def initialize
      # base url
      @url = "https://#{DEFAULT_API_REGION_IDENTIFIER}.api.mailchimp.com/3.0/"
    end
  end

  class << self
    def configure
      yield configuration

      MailchimpAPI::Base.site = configuration.url

      configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
