# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::JsonFormatter do
  it 'initializes properly' do
    json_formatter = MailchimpAPI::JsonFormatter.new 'CollectionName'

    assert_kind_of String, json_formatter.instance_variable_get(:@collection_name)
    assert_equal   'CollectionName', json_formatter.instance_variable_get(:@collection_name)
  end

  it 'successfully decodes json' do
    json_formatter = MailchimpAPI::JsonFormatter.new nil

    decoded_json = json_formatter.decode load_fixture(:lists)

    assert_kind_of Hash, decoded_json

    assert decoded_json.key?('lists')
    assert decoded_json.key?('total_items')
    assert decoded_json.key?('_links')

    assert_equal decoded_json['lists'].count, 2
  end
end
