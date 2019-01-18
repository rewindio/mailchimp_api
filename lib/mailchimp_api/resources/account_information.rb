# frozen_string_literal: true

module MailchimpAPI
  class AccountInformation < Base
    self.collection_name  = ''
    self.element_name     = ''

    class << self
      def find(*arguments)
        scope   = arguments.slice!(0)
        options = arguments.slice!(0) || {}

        prefix_options, query_options = split_options options[:params]

        path = element_path scope, prefix_options, query_options

        instantiate_record format.decode(connection.get(path, headers).body), prefix_options
      end
    end
  end
end
