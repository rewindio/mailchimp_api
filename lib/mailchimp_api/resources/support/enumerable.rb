# frozen_string_literal: true

module MailchimpAPI::Support
  module Enumerable
    def enumerator(page_size: 10, params: {})
      CachingEnumerator.new do |y|
        number_of_items = count params: params
        number_of_pages = (number_of_items / page_size).ceil
        current_page = 0

        loop do
          all_params = {
            offset: current_page * page_size,
            count: page_size
          }.merge(params)

          results = find :all, params: all_params
          current_page += 1

          results.each do |result|
            y.yield result
          end

          break if results.empty? || (current_page >= number_of_pages)
        end
      end
    end
  end
end
