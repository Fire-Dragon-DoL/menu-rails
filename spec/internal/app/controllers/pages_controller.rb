class PagesController < ApplicationController

  def home
    @menu = MenuRails::Menu.get_menu_by_mrid(:client)
  end

  def about
  end

  def dummy1
  end
  
end