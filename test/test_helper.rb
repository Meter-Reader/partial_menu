# frozen_string_literal: true

if ENV['CI']
  require 'simplecov'
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
  SimpleCov.start do
    add_filter '/dummy/'
  end
end

require 'minitest/byebug' if ENV['DEBUG']

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
require 'partial_menu/view_helpers'

ActiveRecord::Migrator.migrations_paths = [
  File.expand_path('../test/dummy/db/migrate', __dir__)
]
require 'rails/test_help'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

require 'rails/test_unit/reporter'
Rails::TestUnitReporter.executable = 'bin/test'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path(
    'fixtures', __dir__
  )
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = "#{ActiveSupport::TestCase.fixture_path}/files"
  ActiveSupport::TestCase.fixtures :all
end

module ActiveSupport
  class TestCase
    include PartialMenu::ViewHelpers
  end
end
