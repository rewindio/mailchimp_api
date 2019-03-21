# frozen_string_literal: true

module MailchimpAPI
  class Feedback < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Feedback

    self.prefix = '/3.0/campaigns/:campaign_id/'

    self.primary_key = :feedback_id
    self.element_name = 'feedback'
    self.collection_name = 'feedback'
  end
end
