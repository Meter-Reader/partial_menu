require 'test_helper'

module PartialMenu
  class Test < ActionView::TestCase
    setup do
      @request.path = '/'
      @request.assign_parameters nil, 'pages', 'index', {}, nil, nil
    end

    test 'PartialMenu is loaded as module' do
      assert_kind_of Module, PartialMenu
    end

    test 'renders default menu when no options given' do
      partial_menu
      assert_select 'ul[class=active]', 1
      assert_select 'li[class=active]' do
        assert_select 'i.fa, i.fa-fw'
        assert_select 'a[href=?]', '/'
        assert_select 'a', 'First item'
      end
      assert_select 'li>hr'
      assert_select 'li[class=nav-item][title=?]', 'Third Item'
      assert_select 'li[class=nav-item][data-original-title=?]', 'Third Item'
      assert_select 'li[class=nav-item] > a' do
        assert_select '[href=?]', '#collapsemain_menu'
        assert_select '[data-parent=?]', '#main'
        assert_select 'i.glyph, i.glyph-fw'
        assert_select 'span', 'Third Item'
      end
      assert_select 'ul[id="#main"]' do
        assert_select 'a[href=link]', 'First Submenu'
        assert_select 'a[href=second_path]', 'menu.second_submenu.title'
      end
    end

    test 'renders menu with specified layout' do
      partial_menu('side')
      assert_select 'ul[class=active]', 1
      assert_select 'li[class=active]' do
        assert_select 'i.fa, i.fa-fw'
        assert_select 'a[href=?]', '/'
        assert_select 'a', 'First item'
      end
      assert_select 'li>hr'
      assert_select 'li[class=nav-item][title=?]', 'Third Item'
      assert_select 'li[class=nav-item][data-original-title=?]', 'Third Item'
      assert_select 'li[class=nav-item] > a' do
        assert_select '[href=?]', '#collapseside_menu'
        assert_select 'i.fa, i.fa-fw'
        assert_select '[data-parent=?]', '#side'
        assert_select 'span', 'Third Item'
      end
      assert_select 'ul[id="#side"]' do
        assert_select 'a[href=link]', 'First Submenu'
        assert_select 'a[href=second_path]', 'menu.second_submenu.title'
      end
    end
  end
end
