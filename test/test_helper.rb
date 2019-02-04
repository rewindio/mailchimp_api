# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/test'
require 'minitest/reporters'

require 'factory_bot'
require 'webmock/minitest'

require 'pry'

require 'mailchimp_api'

Minitest::Reporters.use!

# this felt dirty but it worked.
class Minitest::Spec
  def load_fixture(name, format = :json)
    File.read File.dirname(__FILE__) + "/fixtures/#{name}.#{format}"
  end
end
