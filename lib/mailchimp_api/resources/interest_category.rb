# frozen_string_literal: true

module MailchimpAPI
  class InterestCategory < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::InterestCategory

    self.prefix = '/3.0/lists/:list_id/'
    self.element_name = 'interest-category'
    self.collection_name = 'interest-categories'
  end
end
