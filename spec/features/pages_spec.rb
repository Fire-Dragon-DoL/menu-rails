require 'spec_helper'
require 'active_support/all'

feature "Menu generation" do

  scenario "Ensure capybara is working correctly" do
    visit root_path

    page.should have_content("Capybara working correctly")
  end

  context ":client menu" do

    # scenario "Print Home menu item" do
      ['Home', 'About'].each do |menu_rails_item|
        scenario "Print #{ menu_rails_item } menu item" do
          visit root_path
          
          page.should have_content(menu_rails_item)
        end
      end

  end

end