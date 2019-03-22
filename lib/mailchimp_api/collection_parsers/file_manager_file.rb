# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class FileManagerFile < Base
    def element_key
      'files'
    end
  end
end
