require 'test_helper'
require 'generators/yaml/yaml_generator'

class PartialMenuYamlGeneratorTest < Rails::Generators::TestCase
  tests PartialMenu::YamlGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test 'yaml file created' do
    assert_nothing_raised do
      run_generator
    end
    assert_file 'config/main_menu.yml' do |content|
      assert_match(File.read('lib/generators/yaml/templates/menu.yml'), content)
    end
  end

  test 'yaml file created in custome name' do
    assert_nothing_raised do
      run_generator %w[--type side]
    end
    assert_file 'config/side_menu.yml' do |content|
      assert_match(File.read('lib/generators/yaml/templates/menu.yml'), content)
    end
  end
end
