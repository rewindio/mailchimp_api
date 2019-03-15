# frozen_string_literal: true

module MailchimpAPI
  class CampaignFolder < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::CampaignFolder

    self.element_name = 'campaign-folder'
    self.collection_name = 'campaign-folders'
  end
end
