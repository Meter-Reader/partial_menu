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
  # from +app/views/artial_menu+:
  #
  #  <ul>
  #    <li><s href="/">First item</a></li>
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
    def partial_menu(type = '', options = {}) #:nodoc:
      if type.is_a? Hash
        options = type
        type = nil
      end
      layout = options.delete('layout') || 'menu'
      options.symbolize_keys
      options[:menu] = load_menu_from_yaml(type)
      render layout: layout, locals: options
    end

    private

    def load_menu_from_yaml(type)
      YAML.load_file(
        Rails.root.join("config/#{type.concat('_')}menu.yml")
      )
    end
  end
end
