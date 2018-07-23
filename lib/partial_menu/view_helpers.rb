module PartialMenu
  # View helper implementataion for menu generation
  module ViewHelpers
    def partial_menu(type, options = {})
      layout = options.delete('layout') || 'menu'
      options[:menu] = load_menu_from_yaml(type)
      render layout: layout, locals: options
    end

    private

    def load_menu_from_yaml(type = '')
      @menu = YAML.load_file(
        Rails.root.join("config/#{type.concat('_')}menu.yml")
      )
    end
  end
end
