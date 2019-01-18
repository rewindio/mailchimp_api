# frozen_string_literal: true

require 'mailchimp_api/connection'

module ActiveResource
  class Connection
    attr_reader :response

    prepend MailchimpAPI::Connection::ResponseCapture
    prepend MailchimpAPI::Connection::RequestNotification
  end
end
