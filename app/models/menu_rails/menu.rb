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

    def build_menu_items_from_yaml_data!(data)

      # Chaining
      self
    end

    def self.get_menu_by_mid(identifier)
      base_menu = all_in_file[identifier]

      if base_menu.nil?
        raise ActiveRecord::RecordNotFound.new("No menu found with mid: #{ identifier }")
      else
        @@menu_by_mid                    ||= {}
        @@menu_by_mid[identifier.to_sym] ||= build_menu_from_yaml_data(identifier, all_in_file[identifier])
      end
    end

    def self.all_in_file
      if Rails.env.development? || !defined? @@all_in_file
        @@all_in_file = YAML::load_file(CONFIG_PATH).with_indifferent_access[:menu_rails]
      end

      @@all_in_file
    end

    def self.build_menu_from_yaml_data(identifier, data)
      new(mid: identifier).build_menu_items_from_yaml_data!(data)
    end
    
  end

end