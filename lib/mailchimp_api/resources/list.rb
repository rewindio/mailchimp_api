# frozen_string_literal: true

module MailchimpAPI
  class List < Base
    self.collection_parser = CollectionParsers::List
  end
end
