require 'partial_menu/menu'

module PartialMenu
  # = PartialMenu view helpers
  #
  # This module serves for availability in ActionView templates. It also adds a
  # new view helper: +partial_menu+.
  #
  # == Using the helper without arguments
  # If the helper is called without passing in the type, it will
  # render the default menu using the default view partials.
  #
  # Example:
  #
  #   <%= partial_menu %>
  #
  # ... will result in <tt>menu.yaml</tt> getting displayed using partials
  # from +app/views/partial_menu+:
  #
  #  <ul>
  #    <li><a href="/">First item</a></li>
  #    ...
  #  </ul>
  #
  # Any options defined in the call will be send to +render+ as local variables
  #
  # Example:
  #
  #   <%= partial_menu 'menu', {menu_id:'sidemenu'} %>
  #
  # You can leave out menu type parameter:
  #
  # Example:
  #
  #   <%= partial_menu {menu_id:'sidemenu'} %>
  #
  module ViewHelpers
    def partial_menu(type = 'main', options = {}) #:nodoc:
      if type.is_a? Hash
        options = type
        type = 'main'
      end
      options[:menu] = PartialMenu::Menu.new(load_menu_from_yaml(type))
      options.symbolize_keys!
      render partial: "#{type}_menu/menu", locals: options
    end

    def current_menu?(path)
      request.path == URI(path).path unless path.blank?
    end

    private

    def load_menu_from_yaml(type)
      Psych.load_file(
        Rails.root.join("config/#{type}_menu.yml")
      ).deep_symbolize_keys[:menu]
    end
  end
end
