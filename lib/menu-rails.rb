require 'menu-rails/version'
require 'menu-rails/helpers'

module MenuRails
  autoload :BaseMenu, 'menu-rails/base_menu'

  mattr_accessor :menu_class_name
  @@menu_class_name = 'MenuRails::Menu'

  mattr_accessor :menu_item_class_name
  @@menu_item_class_name = 'MenuRails::MenuItem'
end

# load Rails/Railtie
begin
  require 'rails'
rescue LoadError
  #do nothing
end

if defined? Rails
  require 'menu-rails/engine'
end