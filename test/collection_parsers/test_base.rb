# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::CollectionParsers::Base do
  before do
    json_formatter  = MailchimpAPI::JsonFormatter.new nil
    @decoded_json   = json_formatter.decode load_fixture(:lists)
  end

  it 'valid initialization' do
    collection = MailchimpAPI::CollectionParsers::List.new @decoded_json

    assert_equal collection.count, 2
    assert_equal collection.total_items, 2

    assert_kind_of Array, collection.instance_variable_get(:@elements)

    assert_kind_of Array, collection.instance_variable_get(:@links)
    assert_equal collection.links.count, 3
    assert_kind_of MailchimpAPI::Link, collection.links.first
  end

  it 'has the proper element key' do
    collection = MailchimpAPI::CollectionParsers::Base.new

    assert_equal collection.send(:element_key), 'bases'
  end

  describe '#instantiate_links' do
    it 'instantiates links as Links' do
      collection = MailchimpAPI::CollectionParsers::Base.new

      links = collection.send :instantiate_links, @decoded_json['_links']

      assert_kind_of Array, links
      assert_equal links.count, 3
      assert_kind_of MailchimpAPI::Link, links.first
    end

    it 'safely navigates a nil list of links' do
      collection = MailchimpAPI::CollectionParsers::Base.new

      links = collection.send :instantiate_links, nil

      assert_kind_of NilClass, links
    end
  end
end
