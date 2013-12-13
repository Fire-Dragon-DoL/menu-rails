require 'activerecord-tableless'
require 'symbolize'
require 'active_support/all'

module MenuRails

  class MenuItem < ActiveRecord::Base
    include Symbolize::ActiveRecord
    include Rails.application.routes.url_helpers

    has_no_table

    column :menu_id,                  :integer
    # Stands for MenuRails Item ID
    column :mriid,                    :string
    column :text,                     :string
    column :authorization_can,        :string
    column :authorization_class_name, :string
    column :url_method,               :string
    column :url_text,                 :string
    
    belongs_to :menu

    symbolize :mriid, :authorization_can, :url_method

    def url=(value)
      if value.kind_of? String
        self.url_text   = value
      elsif value.kind_of? Symbol
        self.url_method = value
      else
        raise 'Invalid type for url'
      end
    end

    def url
      self.url_text.nil? ? send(self.url_method) : url_for(self.url_text)
    end

    def authorization=(value)
      self.authorization_can        = value[:can]
      self.authorization_class_name = value[:class_name]
    end

    def authorization
      return nil if self.authorization_can.nil? || self.authorization_class_name.blank?

      { can: self.authorization_can, class_name: self.authorization_class_name }
    end

    def to_s
      self.text
    end
    
  end

end