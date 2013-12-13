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

    def get_menu_item_by_mriid(identifier)
      self.menu_items.select{ |menu_item| menu_item.mriid == identifier.to_sym }.first
    end

    def all_menu_items
      self.menu_items
    end

    private

      def build_menu_items_from_yaml_data!(menu_items_data)
        menu_items_data.each do |menu_item_data|
          menu_item_params   = menu_item_data.values.first.merge(mriid: menu_item_data.keys.first.to_sym)
          authorization      = menu_item_params.delete(:authorization)

          unless authorization.nil?
            menu_item_params[:authorization_can]        = authorization[:can]
            menu_item_params[:authorization_class_name] = authorization[:class_name]
          end

          menu_item          = MenuItem.new(menu_item_params)
          menu_item.menu     = self
          self.menu_items   << menu_item
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