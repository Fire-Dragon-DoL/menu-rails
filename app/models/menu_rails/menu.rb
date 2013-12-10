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

    def build_menu_items_from_yaml_data!(data)

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
              @menu_by_mid[menu_identifier.to_sym] = build_menu_from_yaml_data(menu_identifier,
                                                                               base_menu[menu_identifier])
            end
          end

          @menu_by_mid[identifier.to_sym]
        end
      end

      private

        def build_menu_from_yaml_data(identifier, data)
          new(mid: identifier).build_menu_items_from_yaml_data!(data)
        end

    end
    
  end

end