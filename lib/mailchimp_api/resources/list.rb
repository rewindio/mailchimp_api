# frozen_string_literal: true

module MailchimpAPI
  class List < Base
    extend MailchimpAPI::Support::Countable

    self.collection_parser = CollectionParsers::List

    has_many :interest_categories, class_name: 'MailchimpAPI::InterestCategory'
  end
end
