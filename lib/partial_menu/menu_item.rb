require 'active_link_to'

module PartialMenu
  # Represents menu item in a menu
  class MenuItem
    include ActiveLinkTo

    attr_reader :type
    attr_reader :parent
    attr_reader :uri
    attr_reader :title
    attr_reader :submenu
    attr_reader :id

    ##
    # Contructor which check parameter types and start setup
    #
    # @param [Hash] props The menu list propertiess from the yaml file.
    # @param [PartialMenu::Menu] parent The parent Menu of the item
    #
    # Throws ArgumentError if parameters are not expected type
    #
    def initialize(props, parent)
      unless props.is_a? Hash
        raise ::ArgumentError, "Expected Hash, got #{prop.class}"
      end
      unless parent.is_a? PartialMenu::Menu
        raise ::ArgumentError, "Expected PartialMenu::Menu, got #{parent.class}"
      end
      @parent = parent
      @props = props
      setup
    end

    ##
    # True if menu item has submenu
    #
    # @return [boolean]
    #
    def submenu?
      @submenu != nil
    end

    ##
    # True if menu item is a separator
    #
    # @ return [boolean]
    #
    def separator?
      @type == :separator
    end

    private

    ##
    # Manage parsing order of yaml properties
    #
    def setup
      set_first_entry
      set_type
      set_id
      set_title
      set_uri
      set_submenu
      set_other_attr
    end

    ##
    # Check if there is a +:menu+ property for the menu item and intantiate a
    # new <tt>PartialMenu::Menu</tt> to parse it's content.
    #
    def set_submenu
      @submenu = nil
      return unless @props.key?(:menu)
      @submenu = PartialMenu::Menu.new(
        @props[:menu],
        @parent.type,
        self
      )
    end

    ##
    # Sets type property
    # * +:separator+ - if menu item is has +separator+ entry only
    # * +:link+ - any other occasion
    #
    def set_type
      @type = :item
      @type = @_first_entry[1].to_sym if @_first_entry[1] == 'separator'
    end

    ##
    # Gets and first entry in the yaml file for this particular menu item as it
    # could hold esential information about the entry
    #
    def set_first_entry
      @_first_entry = @props.shift
    end

    ##
    # Set the title of the menu item based ont the +title+ property from the
    # yaml file or if that not exists, use the yaml entry's name titlelized. If
    # menu item is a separator, :title will be an empty string.
    #
    def set_title
      @title = ''
      return if @type == :separator
      @title = @props[:title] if @props.key?(:title)
      @title = @id.titleize if @title.blank?
    end

    ##
    # Sets the menu item id to the entry's name in the yaml
    #
    def set_id
      @id = @_first_entry[0].to_s
    end

    ##
    # Set the URL of the menu item if it is not a separator.
    #
    def set_uri
      @uri = nil
      @uri = @props[:uri] if @type != :separator
    end

    ##
    # Parse additional attributes from yaml
    #
    # If a menu entry defines any addtional attributes above the list below,
    # it will be parsed to an instance variable of the MenuItem.
    #
    # Built-in properties:
    # * +:id+
    # * +:uri+
    # * +:title+
    # * +:menu+
    #
    def set_other_attr
      @props.except(:id, :uri, :title, :menu).each do |name, value|
        instance_variable_set('@' + name.to_s, value)
        define_singleton_method(name) { instance_variable_get("@#{name}") }
      end
    end
  end
end
