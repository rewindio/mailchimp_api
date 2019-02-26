# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

# gem requires
require 'activeresource'
require 'caching_enumerator'

# gem extensions
require 'active_resource/connection_ext'

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
