require 'activerecord-tableless'
require 'symbolize'

module MenuRails

  class MenuItem < ActiveRecord::Base
    include Symbolize::ActiveRecord

    has_no_table

    column :miid, :string
    column :text, :string
    
    belongs_to :menu

    symbolize :miid
    
  end

end