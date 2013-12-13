require 'menu-rails/version'
require 'menu-rails/helpers'

module MenuRails
  autoload :BaseMenu, 'menu-rails/base_menu'
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