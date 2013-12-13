require 'activerecord-tableless'
require 'symbolize'
require 'active_support/all'

module MenuRails

  class MenuItem < ActiveRecord::Base
    include Symbolize::ActiveRecord

    has_no_table

    column :menu_id,                  :integer
    # Stands for MenuRails Item ID
    column :mriid,                    :string
    column :text,                     :string
    column :authorization_can,        :string
    column :authorization_class_name, :string
    
    belongs_to :menu

    symbolize :mriid, :authorization_can

    def authorization
      return nil if self.authorization_can.nil? || self.authorization_class_name.blank?

      { can: self.authorization_can, class_name: self.authorization_class_name }
    end

    def to_s
      self.text
    end
    
  end

end