# frozen_string_literal: true

module MailchimpAPI
  class List < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::List

    has_many :interest_categories, class_name: 'MailchimpAPI::InterestCategory'
    has_many :members,             class_name: 'MailchimpAPI::Member'
    has_many :merge_fields,        class_name: 'MailchimpAPI::MergeField'
    has_many :signup_forms,        class_name: 'MailchimpAPI::SignupForm'
  end
end
