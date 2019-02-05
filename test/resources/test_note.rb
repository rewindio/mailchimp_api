# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::Note do
  ALL_NOTES_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/members/member1234/notes'
  SINGLE_NOTE_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/members/member1234/notes/1234'

  before do
    stub_request(:get, ALL_NOTES_URL)
      .to_return body: load_fixture(:notes)

    stub_request(:get, SINGLE_NOTE_URL)
      .to_return body: load_fixture(:note)
  end

  it 'instantiates proper class' do
    notes = MailchimpAPI::Note.all params: { list_id: 'list1234', member_id: 'member1234' }

    assert_kind_of MailchimpAPI::CollectionParsers::Note, notes
    assert_instance_of MailchimpAPI::Note, notes.first
  end

  it 'requires list_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::Note.all
    end

    assert_match 'list_id prefix_option is missing', error.message
  end

  it 'requires member_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::Note.all params: { list_id: 'list1234' }
    end

    assert_match 'member_id prefix_option is missing', error.message
  end

  describe 'countable' do
    it 'test_countable' do
      stub_request(:get, ALL_NOTES_URL + '?count=0&fields=total_items')
        .to_return body: load_fixture(:count_payload)

      assert_equal 2, MailchimpAPI::Note.count(params: { list_id: 'list1234', member_id: 'member1234' })
    end
  end

  describe 'update' do
    it 'calls PATCH /members/:member_id/notes' do
      stub_request(:patch, SINGLE_NOTE_URL)
        .to_return status: 200

      note = MailchimpAPI::Note.find 1234, params: { list_id: 'list1234', member_id: 'member1234' }
      note.name = 'something else'
      note.save

      assert_not_requested :put, SINGLE_NOTE_URL
      assert_requested :patch, SINGLE_NOTE_URL
    end
  end
end
