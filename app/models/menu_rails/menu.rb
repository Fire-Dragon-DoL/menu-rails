module MenuRails

  class Menu

    attr_accessor :id
    attr_reader   :items

    def initialize
      @items = []
    end
    
  end

end