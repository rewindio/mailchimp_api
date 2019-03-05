# frozen_string_literal: true

module MailchimpAPI::Support
  module PatchUpdate
    protected

    # Overridden - use PATCH instead of PUT for an update.
    def update
      run_callbacks :update do
        connection.patch(element_path(prefix_options), encode, self.class.headers).tap do |response|
          load_attributes_from_response(response)
        end
      end
    end
  end
end
