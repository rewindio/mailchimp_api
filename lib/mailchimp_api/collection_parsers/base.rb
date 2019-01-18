# frozen_string_literal: true

module MailchimpAPI::CollectionParsers
  class Base < ActiveResource::Collection
    attr_accessor :total_items, :links

    def initialize(response = {})
      @links        = instantiate_links response.delete '_links'
      @total_items  = response.delete 'total_items'

      @elements = response[element_key]
    end

    protected

    def element_key
      self.class.name.demodulize.downcase.pluralize
    end

    def instantiate_links(links)
      links&.map do |link|
        MailchimpAPI::Link.new link
      end
    end
  end
end
