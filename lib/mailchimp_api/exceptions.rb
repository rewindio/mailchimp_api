# frozen_string_literal: true

module MailchimpAPI
  class MissingParameter < StandardError
    def initialize(msg = 'Missing Parameter(s)')
      super
    end
  end

  class InvalidOperation < StandardError
    def initialize(msg = 'The requested operation is not valid')
      super
    end
  end
end
