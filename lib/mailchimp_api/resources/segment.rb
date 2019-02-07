# frozen_string_literal: true

module MailchimpAPI
  class Segment < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Segment

    self.prefix = '/3.0/lists/:list_id/'
  end
end
