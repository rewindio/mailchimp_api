# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class InterestCategory < Base
    protected

    def element_key
      'categories'
    end
  end
end
