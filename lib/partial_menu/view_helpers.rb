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
    # rubocop:disable Metrics/MethodLength
    def partial_menu(type = 'main', options = {}) #:nodoc:
      unless (type.is_a? String) || (type.is_a? Hash)
        raise ::ArgumentError, "Expected a String or Hash, got #{type.class}"
      end
      unless options.is_a? Hash
        raise ::ArgumnetError, "Expected a Hash, got #{options.class}"
      end
      if type.is_a? Hash
        options = type
        type = 'main'
      end
      options[:menu] = PartialMenu::Menu.new(load_menu_from_yaml(type))
      options.deep_symbolize_keys!
      render partial: "#{type}_menu/menu", locals: options
    end
    # rubocop:enable Metrics/MethodLength

    private

    ##
    # Load yaml file from config
    #
    # The +type+ parameter is used to create te actual file name. It is
    # expected to:
    # * be in the Rails apps config/ folder
    # * have a name like +type>_menu.yml+
    #
    # All keys are symbolized after loading hte file.
    #
    # @param [String] type The menu type, which identifies the file too
    #
    # @return [Hash] The parsed YAML as hash of objects
    #
    def load_menu_from_yaml(type)
      unless type.is_a? String
        raise ::ArgumentError, "Expected a String, got #{type.class}"
      end
      Psych.load_file(
        Rails.root.join("config/#{type}_menu.yml")
      ).deep_symbolize_keys[:menu]
    end
  end
end
