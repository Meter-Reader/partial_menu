$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'partial_menu/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'partial_menu'
  s.version = PartialMenu::VERSION
  s.authors = ['Peter Nagy']
  s.email = ['peter@meter-reader.com']
  s.homepage = 'https://bitbucket.org/meterreader/partial_menu'
  s.summary = 'Navigation menu builder based on Rails partial views.'
  s.description = "Generating hierarchical menus in Rails should utilize Rails'
  built-in partial views instead of using some kind on HTML code generators.
  This gem just do that."
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'active_link_to', '~> 1.0'
  s.add_dependency 'rails', '~> 5.2'

  s.add_development_dependency 'bundler-audit', '~> 0.6'
  s.add_development_dependency 'minitest-byebug', '~> 0'
  s.add_development_dependency 'overcommit', '~> 0.45'
  s.add_development_dependency 'rails_best_practices', '~> 1.19'
  s.add_development_dependency 'rubocop', '~> 0.58'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'sqlite3', '~> 1.3'
end
