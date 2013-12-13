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
    column :active_controller_only,   :boolean
    column :active_method,            :string
    
    belongs_to :menu

    symbolize :mriid, :authorization_can, :url_method, :active_method

    validates :text,       presence: true
    validates :url_method, presence: { if: -> { self.url_text.blank?   } }
    validates :url_text,   presence: { if: -> { self.url_method.blank? } }

    def url=(value)
      if value.kind_of? String
        self.url_text   = value
      elsif value.kind_of? Symbol
        self.url_method = value
      end
    end

    def url
      self.url_is_string? ? url_for(self.url_text) : send(self.url_method)
    end

    def authorization=(value)
      self.authorization_can        = value[:can]
      self.authorization_class_name = value[:class_name]
    end

    def authorization
      return nil if self.authorization_can.nil? || self.authorization_class_name.blank?

      { can: self.authorization_can, class_name: self.authorization_class_name }
    end

    def active=(value)
      self.active_controller_only = value[:controller_only]
      self.active_method          = value[:method]
    end

    def active?
      return send(self.active_method) unless self.active_method.nil?
      return false if self.url_is_string?

      result = self.menu.controller.controller_name == Rails.application.routes.recognize_path(self.url)[:controller]
      unless self.active_controller_only?
        result &&= self.menu.controller.action_name == Rails.application.routes.recognize_path(self.url)[:action]
      end

      result
    end

    def to_s
      self.text
    end

    def url_is_string?
      self.url_method.nil?
    end
    
  end

end