# frozen_string_literal: true

module MailchimpAPI
  class MergeField < Base
    extend MailchimpAPI::Support::Countable
    extend MailchimpAPI::Support::Enumerable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::MergeField

    self.primary_key = :merge_id
    self.prefix = '/3.0/lists/:list_id/'
    self.element_name = 'merge-field'
    self.collection_name = 'merge-fields'
  end
end
