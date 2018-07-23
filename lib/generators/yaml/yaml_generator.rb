module PartialMenu
  # Generates example menu.yml file in config/
  class YamlGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    copy_file 'menu.yml', 'config/menu.yml'
  end
end
