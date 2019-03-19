# frozen_string_literal: true

module MailchimpAPI
  class Template < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Template
  end
end
