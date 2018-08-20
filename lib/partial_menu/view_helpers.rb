require 'partial_menu/menu'

module PartialMenu
  # = PartialMenu view helpers
  #
  # This module serves for availability in ActionView templates. It also adds a
  # new view helper: +partial_menu+.
  #
  module ViewHelpers
    # rubocop:disable Metrics/MethodLength
    #  == Using the helper
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
    # Any options defined in the call will be send to +render+ as
    # local variables
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
    def partial_menu(type = 'main', options = {})
      unless (type.is_a? String) || (type.is_a? Hash)
        raise ::ArgumentError, "Expected a String or Hash, got #{type.class}"
      end
      unless options.is_a? Hash
        raise ::ArgumentError, "Expected a Hash, got #{options.class}"
      end
      if type.is_a? Hash
        options = type
        type = 'main'
      end
      options[:menu] = PartialMenu::Menu.new(
        load_menu_from_yaml(
          get_yaml_prefix(type, options)
        ),
        type
      )
      options.deep_symbolize_keys!
      render partial: "#{type}_menu/menu", locals: options
    end
    # rubocop:enable Metrics/MethodLength

    private

    def get_yaml_prefix(prefix, options)
      options[:yaml] || prefix
    end

    ##
    # Load yaml file from config
    #
    # The +type+ parameter is used to create te actual file name. It is
    # expected to:
    # * be in the Rails apps config/ folder
    # * have a name like +<prefix>_menu.yml+
    #
    # All keys are symbolized after loading hte file.
    #
    # @param [String] type The yaml file's name prefix
    #
    # @return [Hash] The parsed YAML as hash of objects
    #
    def load_menu_from_yaml(prefix)
      Psych.load_file(
        Rails.root.join("config/#{prefix}_menu.yml")
      ).deep_symbolize_keys[:menu]
    end
  end
end
