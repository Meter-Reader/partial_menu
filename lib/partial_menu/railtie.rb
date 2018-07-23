require 'partial_menu/view_helpers'

module PartialMenu
  # Binding to Rails
  class Railtie < ::Rails::Railtie
    initializer 'partial_menu.view_helpers' do
      ActiveSupport.on_load(:action_view) do
        ActionView::ViewPath.append_view_path('generators/views/templates')
        PartialMenu::ViewHelpers
      end
    end
  end
end
