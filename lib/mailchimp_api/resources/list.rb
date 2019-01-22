# frozen_string_literal: true

module MailchimpAPI
  class List < Base
    extend MailchimpAPI::Support::Countable

    self.collection_parser = CollectionParsers::List
  end
end
