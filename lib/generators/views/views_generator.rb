module PartialMenu
  # Generates views on demand and puts them on app/views/partial_menu
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    directory 'templates', 'app/views/partial_menu'
  end
end
