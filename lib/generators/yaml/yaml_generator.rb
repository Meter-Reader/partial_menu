module PartialMenu
  # Generates example menu.yml file in config/
  class YamlGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    class_option :layout, type: :string, default: 'menu'

    def create_menu_yaml
      @layout = options['layout']
      copy_file 'menu.yml', "config/#{@layout}.yml"
    end
  end
end
