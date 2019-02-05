# frozen_string_literal: true

module MailchimpAPI
  class Note < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Note

    self.prefix = '/3.0/lists/:list_id/members/:member_id/'
  end
end
