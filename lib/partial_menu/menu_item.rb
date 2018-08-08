module PartialMenu
  # Represents menu item in a menu
  class MenuItem
    attr_reader :type
    attr_reader :parent
    attr_reader :uri
    attr_reader :title
    attr_reader :submenu
    attr_reader :id

    def initialize(props, parent)
      raise 'Expected a hash as props' unless props.is_a?(Hash)
      raise 'Expected a PartialMenu::Menu as parent' unless parent.is_a?(
        PartialMenu::Menu
      )
      @parent = parent
      @props = props
      setup
    end

    def setup
      set_type
      set_title
      set_id
      set_uri
      set_submenu
      set_other_attr
    end

    def submenu?
      @submenu != nil
    end

    def separator?
      @type == :separator
    end

    def active?
      false
    end

    private

    def set_submenu
      @submenu = nil
      return if @props.key?(:menu)
      @submenu = PartialMenu::Menu.new(
        @props[:menu],
        @parent.type,
        self
      )
    end

    def set_type
      @_first_entry = @props.shift
      @type = :item
      @type = @_first_entry[1].to_sym if @_first_entry[1] == 'separator'
    end

    def set_title
      @title = ''
      return unless @type != :separator
      @title = @props[:title] if @props.key?(:title)
      @title = @_first_entry[0].to_s.titleize
    end

    def set_id
      @id = @_first_entry[0].to_s
    end

    def set_uri
      @uri = nil
      @uri = @props[:uri] if @type != :separator
    end

    def set_other_attr
      @props.except(@id, :uri, :title, :menu).each do |name, value|
        instance_variable_set('@' + name.to_s, value)
        define_singleton_method(name) { instance_variable_get("@#{name}") }
      end
    end
  end
end
