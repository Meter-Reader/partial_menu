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
    assert_file 'app/views/main_menu/_menu.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_menu.html.erb'),
        content
      )
    end
    assert_file 'app/views/main_menu/_item.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_item.html.erb'),
        content
      )
    end
    assert_file 'app/views/main_menu/_submenu.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_submenu.html.erb'),
        content
      )
    end
    assert_file 'app/views/main_menu/_submenu_item.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_submenu_item.html.erb'),
        content
      )
    end
  end

  test 'view files created with directory specified' do
    run_generator %w[-d side]
    assert_file 'app/views/side_menu/_menu.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_menu.html.erb'),
        content
      )
    end
    assert_file 'app/views/side_menu/_item.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_item.html.erb'),
        content
      )
    end
    assert_file 'app/views/side_menu/_submenu.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_submenu.html.erb'),
        content
      )
    end
    assert_file 'app/views/side_menu/_submenu_item.html.erb' do |content|
      assert_match(
        File.read('lib/generators/views/templates/_submenu_item.html.erb'),
        content
      )
    end
  end
end
