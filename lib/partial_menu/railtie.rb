require 'partial_menu/view_helpers'

module PartialMenu
  # Binding to Rails
  class Railtie < ::Rails::Railtie
    initializer 'partial_menu.view_helpers' do
      ActiveSupport.on_load(:action_view) do
        PartialMenu::ViewHelpers
      end
    end
  end
end
