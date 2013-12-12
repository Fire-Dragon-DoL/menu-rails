require 'menu-rails/version'
require 'menu-rails/helpers'

# load Rails/Railtie
begin
  require 'rails'
rescue LoadError
  #do nothing
end

if defined? Rails
  require 'menu-rails/engine'
end