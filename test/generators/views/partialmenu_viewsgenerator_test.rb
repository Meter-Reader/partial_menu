require 'test_helper'
require 'generators/views/views_generator'

class PartialMenuViewsGeneratorTest < Rails::Generators::TestCase
  tests PartialMenu::ViewsGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator
    end
  end

  test 'view files created' do
    run_generator
    assert_file 'app/views/partial_menu/menu.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/menu.html.erb'),
        content
      )
    end
    assert_file 'app/views/partial_menu/item.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/item.html.erb'),
        content
      )
    end
    assert_file 'app/views/partial_menu/submenu.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/submenu.html.erb'),
        content
      )
    end
    assert_file 'app/views/partial_menu/submenu_item.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/submenu_item.html.erb'),
        content
      )
    end
  end
end
