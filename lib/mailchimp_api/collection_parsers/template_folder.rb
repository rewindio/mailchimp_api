# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class TemplateFolder < Base
    def element_key
      'folders'
    end
  end
end
