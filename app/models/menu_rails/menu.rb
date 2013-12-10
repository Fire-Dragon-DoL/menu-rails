require 'activerecord-tableless'
require 'symbolize'

module MenuRails

  CONFIG_PATH = Rails.root.join('config', 'menu-rails.yml').freeze

  class Menu < ActiveRecord::Base
    include Symbolize::ActiveRecord
    
    has_no_table

    # Stands for MenuID
    column :mid, :string

    has_many :menu_items

    symbolize :mid

    def find_by_mid(identifier)
      base_menu = self.class.all_in_file[identifier]

      if base_menu.nil?
        raise ActiveRecord::RecordNotFound.new("No menu found with mid: #{ identifier }")
      else
        Menu.new(mid: identifier)
      end
    end

    def self.all_in_file
      if Rails.env.development? || !defined? @@all_in_file
        @@all_in_file = YAML::load_file(CONFIG_PATH).with_indifferent_access[:menu_rails]
      end

      @@all_in_file
    end

    private

      def create_menu_items_from_yaml_data(data)

      end
    
  end

end