# frozen_string_literal: true

module MailchimpAPI
  class SegmentMember < Base
    extend MailchimpAPI::Support::Countable

    self.collection_parser = CollectionParsers::SegmentMember
    self.element_name = 'member'
    self.collection_name = 'members'

    self.prefix = '/3.0/lists/:list_id/segments/:segment_id/'

    def update
      raise 'Cannot update SegmentMember. Please use POST to add to a Segment, or DELETE to remove from a Segment.'
    end
  end
end
