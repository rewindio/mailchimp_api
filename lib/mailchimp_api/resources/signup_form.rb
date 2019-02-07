# frozen_string_literal: true

module MailchimpAPI
  class SignupForm < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PostUpdate

    self.collection_parser = CollectionParsers::SignupForm

    self.prefix = '/3.0/lists/:list_id/'
    self.element_name = 'signup-form'
    self.collection_name = 'signup-forms'
  end
end
