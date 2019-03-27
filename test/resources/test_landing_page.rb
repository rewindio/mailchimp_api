# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::LandingPage do
  ALL_LANDING_PAGES_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/landing-pages'
  SINGLE_LANDING_PAGE_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/landing-pages/lp1234'
  LANDING_PAGE_ACTIONS_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/landing-pages/lp1234/actions'

  let(:landing_page) { MailchimpAPI::LandingPage.find 'lp1234' }
  let(:landing_pages) { MailchimpAPI::LandingPage.all }

  before do
    stub_request(:get, ALL_LANDING_PAGES_URL)
      .to_return body: load_fixture(:landing_pages)

    stub_request(:get, SINGLE_LANDING_PAGE_URL)
      .to_return body: load_fixture(:landing_page)
  end

  it 'instantiates proper class' do
    landing_pages = MailchimpAPI::LandingPage.all

    assert_kind_of MailchimpAPI::CollectionParsers::LandingPage, landing_pages
    assert_instance_of MailchimpAPI::LandingPage, landing_pages.first
  end

  describe 'update' do
    it 'calls PATCH instead of POST' do
      stub_request(:patch, SINGLE_LANDING_PAGE_URL)
        .to_return status: 200

      landing_page.name = 'something else'
      landing_page.save

      assert_not_requested :put, SINGLE_LANDING_PAGE_URL
      assert_requested :patch, SINGLE_LANDING_PAGE_URL
    end
  end

  describe 'publish' do
    it 'calls the publish endpoint' do
      stub_request(:post, LANDING_PAGE_ACTIONS_URL + '/publish')
        .to_return status: 204

      landing_page.publish

      assert_requested :post, LANDING_PAGE_ACTIONS_URL + '/publish'
    end
  end

  describe 'unpublish' do
    it 'calls the unpublish endpoint' do
      stub_request(:post, LANDING_PAGE_ACTIONS_URL + '/unpublish')
        .to_return status: 204

      landing_page.unpublish

      assert_requested :post, LANDING_PAGE_ACTIONS_URL + '/unpublish'
    end
  end
end
