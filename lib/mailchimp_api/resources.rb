# frozen_string_literal: true

require 'mailchimp_api/resources/base'

Dir.glob("#{File.dirname(__FILE__)}/resources/*").each { |file| require file if file.end_with? '.rb' }
