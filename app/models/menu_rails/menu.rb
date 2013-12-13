require 'activerecord-tableless'
require 'symbolize'
require 'thread'

module MenuRails

  CONFIG_PATH = Rails.root.join('config', 'menu-rails.yml').freeze

  class Menu < ActiveRecord::Base
    include Symbolize::ActiveRecord
    include MenuRails::BaseMenu

    has_no_table

    # Stands for MenuRails ID
    column :mrid, :string

    has_many :menu_items

    symbolize :mrid

    def get_menu_item_by_mriid(identifier)
      self.menu_items.select{ |menu_item| menu_item.mriid == identifier.to_sym }.first
    end

    def all_menu_items
      self.menu_items
    end

    private

      def build_menu_items_from_yaml_data!(menu_items_data)
        menu_items_data.each do |menu_item_data|
          menu_item_params          = menu_item_data.values.first.merge(mriid: menu_item_data.keys.first.to_sym)
          overwrite_menu_item_class = menu_item_params.delete(:class_name)
          if overwrite_menu_item_class.nil?
            overwrite_menu_item_class = menu_item_class
          else
            overwrite_menu_item_class = overwrite_menu_item_class.constantize
          end
          menu_item                 = overwrite_menu_item_class.new(menu_item_params)
          menu_item.menu            = self
          self.menu_items          << menu_item
        end
        self.menu_items.freeze

        # Chaining
        self
      end

      def menu_item_class
        Rails.application.config.menu_rails.menu_item_class_name.constantize
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
              overwrite_menu_class   = menu.delete(:class_name)
              overwrite_menu_class   = overwrite_menu_class.nil? ? menu_class : overwrite_menu_class.constantize
              @menu_by_mrid[mid_sym] = overwrite_menu_class.new(mrid: mid_sym).send( :build_menu_items_from_yaml_data!,
                                                                                     menu[:menu_items] ).freeze
            end
          end

          @menu_by_mrid[identifier.to_sym]
        end
      end

      private

        def menu_class
          Rails.application.config.menu_rails.menu_class_name.constantize
        end

    end
    
  end

end