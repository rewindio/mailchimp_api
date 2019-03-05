# frozen_string_literal: true

module MailchimpAPI
  class Link < Base
    self.collection_parser = CollectionParsers::Link
  end
end
