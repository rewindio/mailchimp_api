# frozen_string_literal: true

module MailchimpAPI
  class InterestCategory < Base
    extend MailchimpAPI::Support::Countable

    self.collection_parser = CollectionParsers::InterestCategory

    self.prefix = '/3.0/lists/:list_id/'
    self.collection_name = 'interest-categories'

    protected
    
    # This resource only accepts updates via PATCH requests, not standard ActiveResource PUT requests
    def update
      run_callbacks :update do
        connection.patch(element_path(prefix_options), encode, self.class.headers).tap do |response|
          load_attributes_from_response(response)
        end
      end
    end
  end
end
