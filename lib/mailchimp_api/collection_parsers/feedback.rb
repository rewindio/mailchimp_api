# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class Feedback < Base
    def element_key
      'feedback'
    end
  end
end
