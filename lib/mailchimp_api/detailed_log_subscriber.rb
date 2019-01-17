# frozen_string_literal: true

module ActiveResource
  class DetailedLogSubscriber < ActiveSupport::LogSubscriber
    def request(event)
      data = event.payload[:data]
      request_body = data.first

      log_level_method = event.payload[:response].code.to_i < 400 ? :info : :error

      send log_level_method, "Request: #{request_body}" if request_body
      send log_level_method, "Response: #{event.payload[:response].body}" unless event.payload[:response].header['content-type'] == 'text/html'
    end

    def logger
      ActiveResource::Base.logger
    end
  end
end

ActiveResource::DetailedLogSubscriber.attach_to :active_resource_detailed
