# frozen_string_literal: true

module MailchimpAPI
  class Segment < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Segment

    self.prefix = '/3.0/lists/:list_id/'

    # The path to get segment members is '/3.0/lists/:list_id/segments/:segment_id/members'
    # Unfortunately, ActiveResource does not support nested resources, only single parent resources:
    #
    # https://github.com/rails/activeresource/blob/4accda8bc03ceae0ad626f8cec0b4751e89a58ad/lib/active_resource/associations.rb#L151
    #
    # Using a has_many, there is no way to include the `list_id`, so we just create our own members method.
    def members(params = {})
      @members ||= MailchimpAPI::SegmentMember.find(:all, params: { segment_id: id }.deep_merge(prefix_options).deep_merge(params))
    end
  end
end
