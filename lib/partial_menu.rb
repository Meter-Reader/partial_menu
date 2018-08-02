# PartailMenu implementation class
module PartialMenu
end

if defined?(Rails::Railtie)
  require 'partial_menu/railtie'
elsif defined?(Rails::Initializer)
  raise 'partial_menu is not compatible with Rails 2.3 or older'
end
