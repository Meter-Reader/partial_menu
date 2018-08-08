module PartialMenu
  # Generates views on demand and puts them on app/views/partial_menu
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
    # rubocop:disable Metrics/LineLength
    class_option :partial_dir,
                 type: :string,
                 default: 'main',
                 aliases: '-d',
                 desc: 'The directory in the /app/views/ folder to put templates in.'
    # rubocop:enable Metrics/LineLength
    def copy_templates
      @dir = options['partial_dir']
      directory '.', "app/views/#{@dir}_menu"
    end
  end
end
