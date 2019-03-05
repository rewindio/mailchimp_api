# frozen_string_literal: true

module MailchimpAPI::Support
  module Countable
    def count(params = {})
      all_params = params.deep_merge(params: { fields: 'total_items', count: 0 })

      all(all_params).total_items
    end
  end
end
