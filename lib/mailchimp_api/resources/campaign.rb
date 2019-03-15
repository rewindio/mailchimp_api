# frozen_string_literal: true

module MailchimpAPI
  class Campaign < Base
    extend MailchimpAPI::Support::Countable

    include MailchimpAPI::Support::PatchUpdate

    self.collection_parser = CollectionParsers::Campaign

    # Define all bodiless, non-RESTful actions
    %w[
      cancel-send
      create-resend
      pause
      replicate
      resume
      unschedule
    ].each do |path_name|
      define_method path_name.sub('-', '_') do
        path = element_path(prefix_options) + "/actions/#{path_name}"
        connection.post path, nil, self.class.headers
      end
    end

    # Calls the '/send' endpoint, but we obviously can't override the Ruby 'send' method.
    def send_campaign
      path = element_path(prefix_options) + '/actions/send'
      connection.post path, nil, self.class.headers
    end

    def schedule(time, use_timewarp = false, batch_delivery = false)
      path = element_path(prefix_options) + '/actions/schedule'
      connection.post path, { schedule_time: time.iso8601, timewarp: use_timewarp, batch_delivery: batch_delivery }.to_json, self.class.headers
    end

    # type: String. 'html' or 'plaintext'
    def test(emails = [], type = 'html')
      return unless emails.present?

      path = element_path(prefix_options) + '/actions/test'
      connection.post path, { test_emails: emails, send_type: type }.to_json, self.class.headers
    end
  end
end
