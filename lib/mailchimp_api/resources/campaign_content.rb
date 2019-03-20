# frozen_string_literal: true

module MailchimpAPI
  class CampaignContent < Base
    extend MailchimpAPI::Support::Countable

    self.prefix = '/3.0/campaigns/:campaign_id/'
    self.element_name = 'content'
    self.collection_name = 'content'

    class << self
      # CampaignContent doesn't have an ID
      # `/3.0/campaigns/:campaign_id/content` only returns a single object
      # this overrides ActiveResource::Base#find to massage all calls into
      def find(*args)
        options = args.slice!(1) || {}

        prefix_options, query_options = split_options options[:params]

        path = collection_path prefix_options, query_options

        instantiate_record format.decode(connection.get(path, headers).body), prefix_options
      end
    end
  end
end
