require 'activerecord-tableless'
require 'symbolize'

module MenuRails

  class MenuItem < ActiveRecord::Base
    include Symbolize::ActiveRecord

    has_no_table

    column :menu_id, :integer
    # Stands for MenuRails Item ID
    column :mriid,   :string
    column :text,    :string
    
    belongs_to :menu

    symbolize :mriid
    
  end

end