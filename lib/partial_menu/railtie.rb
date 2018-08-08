require 'partial_menu/view_helpers'

module PartialMenu
  # Binding to Rails
  class Railtie < ::Rails::Railtie
    initializer 'partial_menu.view_helpers' do
      ActiveSupport.on_load(:action_view) do
        PartialMenu::ViewHelpers
      end
    end

    generators do
      require 'generators/yaml/yaml_generator'
      require 'generators/views/views_generator'
    end
  end
end
