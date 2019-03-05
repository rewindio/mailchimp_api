# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::SignupForm do
  ALL_SIGNUP_FORMS_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/signup-forms'

  let(:signup_forms) { MailchimpAPI::SignupForm.all params: { list_id: 'list1234' } }

  before do
    stub_request(:get, ALL_SIGNUP_FORMS_URL)
      .to_return body: load_fixture(:signup_forms)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::SignupForm, signup_forms
    assert_instance_of MailchimpAPI::SignupForm, signup_forms.first
  end

  it 'raises an error with no list_id prefix_option' do
    error =
      assert_raises ActiveResource::MissingPrefixParam do
        MailchimpAPI::SignupForm.all
      end

    assert_match 'list_id prefix_option is missing', error.message
  end

  describe 'update' do
    let(:signup_form) { MailchimpAPI::SignupForm.first params: { list_id: 'list1234' } }

    before do
      stub_request(:post, "#{ALL_SIGNUP_FORMS_URL}/")
        .to_return status: 200
    end

    it 'uses POST instead of PUT for an update' do
      signup_form.header.text = 'Words'
      signup_form.save

      assert_not_requested :put, "#{ALL_SIGNUP_FORMS_URL}/"
      assert_requested :post, "#{ALL_SIGNUP_FORMS_URL}/"
    end
  end
end
