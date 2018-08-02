require 'test_helper'

module PartialMenu
  class Test < ActionView::TestCase
    test 'PartialMenu is loaded as module' do
      assert_kind_of Module, PartialMenu
    end

    test 'renders default menu when no options given' do
      assert_equal '<ul><li><a href="/">First item</a></li></ul>', partial_menu
    end

    test 'renders menu with specified layout' do
      skip
    end

    test 'renders menu with options given' do
      skip
    end
  end
end
