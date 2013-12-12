class PagesController < ApplicationController

  def home
    @menu = MenuRails::Menu.get_menu_by_mrid(:client)
  end
  
end