module MenuRails::Helpers

  module MenuHelper

    def menu_rails(menu)
      raise 'Block must be provided' unless block_given?
      
      block_result = nil

      menu.display_for_controller(self.controller) do
        menu_items = menu_rails_all_items(menu)

        block_result = yield(menu_items)
      end

      block_result
    end

    def menu_rails_each(menu)
      raise 'Block must be provided' unless block_given?

      menu_rails(menu) do |menu_items|
        menu_items.each_with_index do |menu_item, index|
          yield(menu_item, index)
        end
      end
    end

    def menu_rails_all_items(menu)
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

      menu_items
    end

  end

end