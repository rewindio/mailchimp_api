# MailchimpAPI
[![Build Status](https://travis-ci.org/rewindio/mailchimp_api.svg?branch=master)](https://travis-ci.org/rewindio/mailchimp_api)

The best way to consume Mailchimp's v3 APIs!

## Installation

###### Add this line to your application's Gemfile
```ruby
  gem 'mailchimp_api'
```

## Usage

###### Basic Account object
```ruby
# frozen_string_literal: true

require 'mailchimp_api'

class Account
  attr_accessor :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def with_mailchimp_session(&block)
    MailchimpAPI::Session.temp access_token, &block
  end
end

account = Account.new 'xxxyyyzzz-us7'
```

###### GET `/`
```ruby
account.with_mailchimp_session { MailchimpAPI::AccountInformation.find '' }
```

###### GET `/lists`
```ruby
account.with_mailchimp_session { MailchimpAPI::List.all }
```

## Development

After checking out the repository, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment. You can create a file in the root of the project called `dev-config.yml` and add your API key to it:
```
api_key: <your-api-key>
```
This will tell the console to pre-authenticate the Mailchimp session, making it easier to test.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rewindio/mailchimp_api.
