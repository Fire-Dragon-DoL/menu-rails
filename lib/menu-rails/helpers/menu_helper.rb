module MenuRails::Helpers

  module MenuHelper

    def menu_rails(menu, &block)
      menu_items = menu.all_menu_items

      menu_items = menu_items.select do |menu_item|
        if respond_to?(:can?)
          if menu_item.authorization.nil?
            true
          else
            can?(menu_item.authorization[:can], menu_item.authorization[:class_name].constantize)
          end
        else
          true
        end
      end

      return menu_items.each(&block) if block_given?
      
      menu_items
    end

  end

end