module PartialMenu
  # Generates example menu.yml file in config/
  class YamlGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    class_option :type,
                 type: :string,
                 default: 'main',
                 aliases: '-t',
                 desc: 'Creates the menu descriptor in /config/{type}_menu.yml'

    def create_menu_yaml
      @type = options['type']
      copy_file 'menu.yml', "config/#{@type}_menu.yml"
    end
  end
end
