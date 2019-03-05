# frozen_string_literal: true

module MailchimpAPI
  class Interest < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Interest

    self.prefix = '/3.0/lists/:list_id/interest-categories/:interest_category_id/'
  end
end
