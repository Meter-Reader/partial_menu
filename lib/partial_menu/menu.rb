require 'partial_menu/menu_item'

module PartialMenu
  # Represents a menu with menu items
  class Menu
    attr_reader :type
    attr_reader :items
    attr_reader :parent
    attr_reader :id

    def initialize(props, type = 'main', parent = nil)
      raise "Expected a array but got #{props.class}" unless props.is_a? Array
      raise "Expected a string but got #{type.class}" unless type.is_a? String
      @type = type
      @items = []
      @parent = parent
      set_id
      add_items(props)
    end

    private

    def add_items(items)
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
