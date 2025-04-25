# frozen_string_literal: true

require 'partial_menu/menu_item'

module PartialMenu
  # Represents a menu with menu items
  class Menu
    attr_reader :layout, :items, :parent, :id

    # rubocop:disable Metrics/MethodLength
    def initialize(props, layout = 'main', parent = nil)
      raise ::ArgumentError, "Expected an Array, got #{props.class}" unless props.is_a? Array
      raise ::ArgumentError, "Expected a String, got #{layout.class}" unless layout.is_a? String
      unless parent.nil? || (parent.is_a? PartialMenu::MenuItem)
        raise ::ArgumentError, "Expected MenuItem or nil, got #{parent.class}"
      end

      @props = props
      @layout = layout
      @items = []
      @parent = parent
      set_id
      add_items(props)
    end
    # rubocop:enable Metrics/MethodLength

    ##
    # True if current url relates to any child menu item's uri
    #
    # @params [ActionView] Needs view context to get current request details
    #
    # @retrun [boolean]
    #
    def active?(view)
      @items.each do |item|
        return true if item.active?(view)
      end
      false
    end

    private

    def add_items(items)
      items.each do |item|
        @items << PartialMenu::MenuItem.new(item, self)
      end
    end

    def set_id
      @id = if @parent.try(:class) == 'PartialMenu::MenuItem'
              "#{@parent.id}_submenu"
            else
              "#{@layout}_menu"
            end
    end
  end
end
