# frozen_string_literal: true

require 'mailchimp_api/collection_parsers/base'

Dir.glob("#{File.dirname(__FILE__)}/collection_parsers/*").each { |file| require file if file.end_with? '.rb' }
