module MenuRails

  class MenuItem < ActiveRecord::Base
    has_no_table

    column :miid, :string
    column :text, :string
    
    belongs_to :menu
    
  end

end