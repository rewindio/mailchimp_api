# frozen_string_literal: true

module MailchimpAPI
  class FileManagerFolder < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::FileManagerFolder

    self.element_name = 'file-manager/folder'
    self.collection_name = 'file-manager/folders'
  end
end
