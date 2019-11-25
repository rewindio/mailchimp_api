# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

# gem requires
require 'activeresource'
require 'caching_enumerator'

require 'mailchimp_api/version'
require 'mailchimp_api/configuration'

module MailchimpAPI
end

require 'mailchimp_api/json_formatter'
require 'mailchimp_api/connection'
require 'mailchimp_api/detailed_log_subscriber'
require 'mailchimp_api/exceptions'
require 'mailchimp_api/session'

require 'mailchimp_api/collection_parsers'
require 'mailchimp_api/resources'

if MailchimpAPI::Base.respond_to?(:connection_class)
  MailchimpAPI::Base.connection_class = MailchimpAPI::Connection
else
  require 'active_resource/connection_ext'
end
