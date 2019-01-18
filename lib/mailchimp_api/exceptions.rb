# frozen_string_literal: true

module MailchimpAPI
  class MissingParameter < StandardError
    def initialize(msg = 'Missing Parameter(s)')
      super
    end
  end
end
