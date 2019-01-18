# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/test'
require 'minitest/reporters'

require 'factory_bot'

require 'pry'

require 'mailchimp_api'

Minitest::Reporters.use!

module Test
  module Unit
    class TestCase < Minitest::Test
      include FactoryBot::Syntax::Methods

      def load_fixture(name, format = :json)
        File.read File.dirname(__FILE__) + "/fixtures/#{name}.#{format}"
      end
    end
  end
end
