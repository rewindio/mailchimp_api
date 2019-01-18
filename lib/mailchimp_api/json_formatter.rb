# frozen_string_literal: true

module MailchimpAPI
  class JsonFormatter
    include ActiveResource::Formats::JsonFormat

    attr_reader :collection_name

    def initialize(collection_name)
      @collection_name = collection_name.to_s
    end

    def decode(json)
      ActiveSupport::JSON.decode json.presence
    end
  end
end
