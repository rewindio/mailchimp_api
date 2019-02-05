# frozen_string_literal: true

module MailchimpAPI
  class InterestCategory < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::InterestCategory

    self.prefix = '/3.0/lists/:list_id/'
    self.element_name = 'interest-category'
    self.collection_name = 'interest-categories'

    # The path to get interests is '/3.0/lists/:list_id/interest-categories/:interest_category_id'
    # Unfortunately, ActiveResource does not support nested resources, only single parent resources:
    #
    # https://github.com/rails/activeresource/blob/4accda8bc03ceae0ad626f8cec0b4751e89a58ad/lib/active_resource/associations.rb#L151
    #
    # Using a has_many, there is no way to include the `list_id`, so we just create our own interests method.
    def interests
      @interests ||= MailchimpAPI::Interest.find(:all, params: { interest_category_id: id }.merge(prefix_options))
    end
  end
end
