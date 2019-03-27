# frozen_string_literal: true

module MailchimpAPI
  class LandingPage < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::LandingPage

    self.element_name = 'landing-page'
    self.collection_name = 'landing-pages'

    def publish
      path = element_path(prefix_options) + '/actions/publish'
      connection.post path, nil, self.class.headers
    end

    def unpublish
      path = element_path(prefix_options) + '/actions/unpublish'
      connection.post path, nil, self.class.headers
    end
  end
end
