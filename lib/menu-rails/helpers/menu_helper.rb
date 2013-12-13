module MenuRails::Helpers

  module MenuHelper

    def menu_rails(menu, &block)
      return menu.all_menu_items.each(&block) if block_given?
      
      menu.all_menu_items
    end

  end

end