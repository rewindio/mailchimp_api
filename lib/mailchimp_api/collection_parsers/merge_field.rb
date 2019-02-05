# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class MergeField < Base
    protected

    def element_key
      'merge_fields'
    end
  end
end
