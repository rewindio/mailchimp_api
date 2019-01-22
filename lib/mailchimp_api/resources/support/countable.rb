# frozen_string_literal: true

module MailchimpAPI::Support
  module Countable
    def count
      all(params: { fields: 'total_items', count: 0 }).total_items
    end
  end
end
