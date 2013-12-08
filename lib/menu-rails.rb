require "menu-rails/version"

module MenuRails
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