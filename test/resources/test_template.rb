# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Template do
  BASE_TEMPLATE_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/templates'
  TEMPLATE_ID = 1

  before do
    stub_request(:get, BASE_TEMPLATE_URL)
      .to_return body: load_fixture(:templates)

    stub_request(:get, BASE_TEMPLATE_URL + "/#{TEMPLATE_ID}")
      .to_return body: load_fixture(:template)
  end

  it 'instantiates proper class' do
    templates = MailchimpAPI::Template.all

    assert_kind_of MailchimpAPI::CollectionParsers::Template, templates
    assert_instance_of MailchimpAPI::Template, templates.first
  end

  describe 'countable' do
    it 'gets proper count' do
      stub_request(:get, BASE_TEMPLATE_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:templates)

      assert_equal 126, MailchimpAPI::Template.count
    end
  end

  describe 'update' do
    it 'calls PATCH /templates/:TEMPLATE_ID/' do
      stub_request(:patch, BASE_TEMPLATE_URL + "/#{TEMPLATE_ID}")
        .to_return status: 200

      template = MailchimpAPI::Template.find TEMPLATE_ID
      template.name = 'Something else'
      template.save

      assert_not_requested :put, BASE_TEMPLATE_URL + "/#{TEMPLATE_ID}"
      assert_requested :patch, BASE_TEMPLATE_URL + "/#{TEMPLATE_ID}"
    end
  end
end
