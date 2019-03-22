# frozen_string_literal: true

module MailchimpAPI
  class FileManagerFile < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::FileManagerFile

    self.element_name = 'file-manager/file'
    self.collection_name = 'file-manager/files'
  end
end
