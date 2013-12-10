require 'activerecord-tableless'
require 'symbolize'
require 'thread'

module MenuRails

  CONFIG_PATH = Rails.root.join('config', 'menu-rails.yml').freeze

  class Menu < ActiveRecord::Base
    include Symbolize::ActiveRecord

    has_no_table

    # Stands for MenuRails ID
    column :mrid, :string

    has_many :menu_items

    symbolize :mrid

    private

      def build_menu_items_from_yaml_data!(menu_items_data)
        menu_items_data.each do |menu_item_data|
          menu_item        = MenuItem.new(menu_item_data)
          menu_item.menu   = self
          self.menu_items << menu_item
        end
        self.menu_items.freeze

        # Chaining
        self
      end

    class << self

      SEMAPHORE = Mutex.new

      def get_menu_by_mrid(identifier)
        SEMAPHORE.synchronize do
          if @menu_by_mrid.nil?
            base_menu     = YAML::load_file(CONFIG_PATH).with_indifferent_access[:menu_rails]
            @menu_by_mrid = {}

            base_menu.each do |menu_identifier, menu|
              mid_sym                = menu_identifier.to_sym
              @menu_by_mrid[mid_sym] = new(mrid: mid_sym).send(:build_menu_items_from_yaml_data!, menu[:menu_items]).freeze
            end
          end

          @menu_by_mrid[identifier.to_sym]
        end
      end

    end
    
  end

end