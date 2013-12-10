require 'activerecord-tableless'
require 'symbolize'
require 'thread'

module MenuRails

  CONFIG_PATH = Rails.root.join('config', 'menu-rails.yml').freeze

  class Menu < ActiveRecord::Base
    include Symbolize::ActiveRecord

    has_no_table

    # Stands for MenuID
    column :mid, :string

    has_many :menu_items

    symbolize :mid

    private

      def build_menu_items_from_yaml_data!(menu_items_data)
        menu_items_data.each do |menu_item_data|
          self.menu_items << MenuItem.new(menu_item_data)
        end

        # Chaining
        self
      end

    class << self

      SEMAPHORE = Mutex.new

      def get_menu_by_mid(identifier)
        SEMAPHORE.synchronize do
          if @menu_by_mid.nil?
            base_menu = YAML::load_file(CONFIG_PATH).with_indifferent_access[:menu_rails]
            @menu_by_mid = {}

            base_menu.each_key do |menu_identifier|
              mid_sym = menu_identifier.to_sym
              @menu_by_mid[mid_sym] = new(mid: identifier).send( :build_menu_items_from_yaml_data!,
                                                                 base_menu[mid_sym][:menu_items] )
            end
          end

          @menu_by_mid[identifier.to_sym]
        end
      end

    end
    
  end

end