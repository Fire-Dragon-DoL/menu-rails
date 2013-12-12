module MenuRails::Helpers

  module MenuHelper

    def menu_rails_each(menu, &block)
      menu.all_menu_items.each(&block)
    end

    def menu_rails_item(menu_item)
      menu_item.text
    end

  end

end