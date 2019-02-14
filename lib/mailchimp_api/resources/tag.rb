# frozen_string_literal: true

module MailchimpAPI
  class Tag < Base
    extend MailchimpAPI::Support::Countable

    self.collection_parser = CollectionParsers::Tag

    self.prefix = '/3.0/lists/:list_id/members/:member_id/'
  end
end
