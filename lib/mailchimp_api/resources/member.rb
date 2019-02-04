# frozen_string_literal: true

module MailchimpAPI
  class Member < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Member

    self.prefix = '/3.0/lists/:list_id/'

    # non-RESTful actions

    # Delete all personally identifiable information related to a list member, and remove them from a list. This will make it impossible to re-import the list member
    def permanent_delete
      run_callbacks :destroy do
        path = element_path(prefix_options) + '/actions/delete-permanent'

        connection.post path, nil, self.class.headers
      end
    end
  end
end
