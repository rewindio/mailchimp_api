# frozen_string_literal: true

lib = File.expand_path 'lib', __dir__
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'mailchimp_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'mailchimp_api'
  spec.version       = MailchimpAPI::VERSION
  spec.authors       = ['rewind.io']
  spec.email         = ['team@rewind.io']

  spec.summary       = "Consume Mailchimp's API using ActiveResource"
  spec.description   = "Consume Mailchimp's API using ActiveResource"
  spec.homepage      = 'https://github.com/rewindio/mailchimp_api.git'
  spec.license       = 'MIT'

  spec.require_paths = %w[lib]

  spec.files = `git ls-files -z lib`.split("\x0") + %w[CHANGELOG.md LICENSE README.md]

  spec.add_runtime_dependency 'activeresource', '~> 5.1.0'

  spec.add_development_dependency 'bundler', '~> 2.0.0'
  spec.add_development_dependency 'rake', '~> 11.2.2'

  spec.add_development_dependency 'http_logger', '~> 0.5.1'
  spec.add_development_dependency 'pry-byebug', '~> 3.6.0'

  spec.add_development_dependency 'factory_bot', '~> 4.11.0'
  spec.add_development_dependency 'guard', '~> 2.15.0'
  spec.add_development_dependency 'guard-minitest', '~> 2.4.0'
  spec.add_development_dependency 'minitest', '~> 5.11.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.3.6'
end