require 'test_helper'
require 'generators/yaml/yaml_generator'

class PartialMenuYamlGeneratorTest < Rails::Generators::TestCase
  tests PartialMenu::YamlGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator
    end
  end

  test 'yaml file created' do
    run_generator
    assert_file 'config/menu.yml' do |content|
      assert_match(File.read('lib/generators/yaml/templates/menu.yml'), content)
    end
  end
end
