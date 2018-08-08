require 'test_helper'

module PartialMenu
  include PartialMenu::VewHelpers

  class Test < ActionView::TestCase
    test 'PartialMenu is loaded as module' do
      assert_kind_of Module, PartialMenu
    end

    test 'renders default menu when no options given' do
      assert_equal '<ul>
  <li>
    <i class="fa fa-fw fa-user"></i>
    <a href="root_path">First item</a>
  </li>
  <li>
  </li>
  <li class="nav-item" title="Third Item" data-original-title="Third Item">
    <a class="nav-link nav-link-collapse collapsed"
      data-toggle="collapse" href="#collapsemain_menu" data-parent="#main">
      <span class="nav-link-text">Third Item</span>
    </a>
    <li>First Submenu</li>
    <li>
      <a href="second_path">menu.second_submenu.title</a>
    </li>
  </li>
</ul>'.gsub(/[[:space:]]/, ''), partial_menu.gsub(/[[:space:]]/, '')
    end

    test 'renders menu with specified layout' do
      skip
    end

    test 'renders menu with options given' do
      skip
    end
  end
end
