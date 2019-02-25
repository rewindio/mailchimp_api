# frozen_string_literal: true

require 'test_helper'

describe MailchimpAPI::SegmentMember do
  ALL_SEGMENT_MEMBERS_URL = 'https://__API_REGION_IDENTIFIER__.api.mailchimp.com/3.0/lists/list1234/segments/s1234/members'

  let(:segment_members) { MailchimpAPI::SegmentMember.all params: { list_id: 'list1234', segment_id: 's1234'  } }

  before do
    stub_request(:get, ALL_SEGMENT_MEMBERS_URL)
      .to_return body: load_fixture(:segment_members)
  end

  it 'instantiates the class properly' do
    assert_kind_of MailchimpAPI::CollectionParsers::SegmentMember, segment_members
    assert_instance_of MailchimpAPI::SegmentMember, segment_members.first
  end

  it 'requires list_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::SegmentMember.all
    end

    assert_match 'list_id prefix_option is missing', error.message
  end

  it 'requires segment_id prefix' do
    error = assert_raises ActiveResource::MissingPrefixParam do
      MailchimpAPI::SegmentMember.all params: { list_id: 'list1234' }
    end

    assert_match 'segment_id prefix_option is missing', error.message
  end

  describe 'update' do
    it 'is not supported' do
      segment_member = MailchimpAPI::SegmentMember.first params: { list_id: 'list1234', segment_id: 's1234' }
      error =
        assert_raises MailchimpAPI::InvalidOperation do
          segment_member.email_address = 'nope'
          segment_member.save
        end

      assert_match 'Cannot update SegmentMember. Please use POST to add to a Segment, or DELETE to remove from a Segment.', error.message
    end
  end
end
