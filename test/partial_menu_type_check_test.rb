# frozen_string_literal: true

require 'test_helper'

module PartialMenu
  class Test < ActionView::TestCase
    test 'Variable type checks' do
      assert_raises ArgumentError do
        partial_menu :wrong
      end
      assert_raises ArgumentError do
        partial_menu 'good', :wrong
      end
      assert_raises ArgumentError do
        PartialMenu::Menu.new(:wrong)
      end
      assert_raises ArgumentError do
        PartialMenu::Menu.new([], :wrong)
      end
      assert_raises ArgumentError do
        PartialMenu::Menu.new([], 'good', :wrong)
      end
      assert_raises ArgumentError do
        PartialMenu::MenuItem.new(:wrong)
      end
      assert_raises ArgumentError do
        PartialMenu::MenuItem.new({}, :wrong)
      end
    end
  end
end
