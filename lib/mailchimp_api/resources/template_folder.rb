# frozen_string_literal: true

module MailchimpAPI
  class TemplateFolder < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::TemplateFolder

    self.element_name = 'template-folder'
    self.collection_name = 'template-folders'
  end
end
