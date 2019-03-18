# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class FileManagerFolder < Base
    def element_key
      'folders'
    end
  end
end
