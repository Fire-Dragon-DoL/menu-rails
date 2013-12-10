require 'activerecord-tableless'

module MenuRails

  CONFIG_PATH = Rails.root.join('config', 'menu-rails.yml')

  class Menu < ActiveRecord::Base
    has_no_table

    # Stands for MenuID
    column :mid, :string

    has_many :menu_items

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
    
  end

end