require 'partial_menu/menu_item'

module PartialMenu
  # Represents a menu with menu items
  class Menu
    attr_reader :type
    attr_reader :items
    attr_reader :parent
    attr_reader :id

    # rubocop:disable Metrics/MethodLength
    def initialize(props, type = 'main', parent = nil)
      unless props.is_a? Array
        raise ::ArgumentError, "Expected an Array, got #{props.class}"
      end
      unless type.is_a? String
        raise ::ArgumentError, "Expected a String, got #{type.class}"
      end
      unless parent.nil? || (parent.is_a? PartialMenu::MenuItem)
        raise ::ArgumentError, "Expected MenuItem or nil, got #{parent.class}"
      end
      @type = type
      @items = []
      @parent = parent
      set_id
      add_items(props)
    end
    # rubocop:enable Metrics/MethodLength

    private

    def add_items(items)
      unless items.is_a? Array
        raise ::ArgumentError, "Expected an Array, got #{items.class}"
      end
      items.each do |item|
        @items << PartialMenu::MenuItem.new(item, self)
      end
    end

    def set_id
      @id = if @parent.try(:class) == 'PartialMenu::MenuItem'
              @parent.id + '_submenu'
            else
              @type + '_menu'
            end
    end
  end
end
