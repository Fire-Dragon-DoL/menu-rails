require 'rails'

module MenuRails #:nodoc:
  class Engine < ::Rails::Engine #:nodoc:
    isolate_namespace MenuRails

    initializer "menu-rails.helpers" do
      ActiveSupport.on_load(:action_view) do
        include MenuRails::Helpers::MenuHelper
      end
    end
  end
end