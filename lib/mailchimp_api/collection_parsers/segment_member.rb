# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class SegmentMember < Base
    def element_key
      'members'
    end
  end
end
