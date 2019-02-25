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
    def notes(params = {})
      @notes ||= MailchimpAPI::Note.find(:all, params: { member_id: id }.deep_merge(prefix_options).deep_merge(params))
    end

    # The path to get tags is '/3.0/lists/:list_id/members/:member_id'
    # Unfortunately, ActiveResource does not support nested resources, only single parent resources:
    #
    # https://github.com/rails/activeresource/blob/4accda8bc03ceae0ad626f8cec0b4751e89a58ad/lib/active_resource/associations.rb#L151
    #
    # Using a has_many, there is no way to include the `list_id`, so we just create our own tags method.
    def tags(params = {})
      @tags ||= MailchimpAPI::Tag.find(:all, params: { member_id: id }.deep_merge(prefix_options).deep_merge(params))
    end

    # non-RESTful actions

    # Delete all personally identifiable information related to a list member, and remove them from a list. This will make it impossible to re-import the list member
    def permanent_delete
      run_callbacks :destroy do
        path = element_path(prefix_options) + '/actions/delete-permanent'

        connection.post path, nil, self.class.headers
      end
    end

    # Tags should be provided as an array of the form [{name: 'tag1', status: 'active'}, {name: 'tag2', status: 'inactive'}]
    def update_tags(tags)
      path = element_path(prefix_options) + '/tags'
      body = { tags: tags }.to_json

      connection.post path, body, self.class.headers
    end
  end
end
