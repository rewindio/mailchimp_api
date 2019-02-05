# frozen_string_literal: true

module MailchimpAPI
  class Member < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Member

    self.prefix = '/3.0/lists/:list_id/'

    # The path to get notes is '/3.0/lists/:list_id/members/:member_id'
    # Unfortunately, ActiveResource does not support nested resources, only single parent resources:
    #
    # https://github.com/rails/activeresource/blob/4accda8bc03ceae0ad626f8cec0b4751e89a58ad/lib/active_resource/associations.rb#L151
    #
    # Using a has_many, there is no way to include the `list_id`, so we just create our own notes method.
    def notes
      @notes ||= MailchimpAPI::Note.find(:all, params: { member_id: id }.merge(prefix_options))
    end

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
