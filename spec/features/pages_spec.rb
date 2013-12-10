require 'spec_helper'
require 'active_support/all'

def menu_rails
  @menu_rails ||= YAML::load_file(MenuRails::CONFIG_PATH).with_indifferent_access[:menu_rails]
end

feature "Menu generation" do

  scenario "Ensure capybara is working correctly" do
    visit root_path

    page.should have_content("Capybara working correctly")
  end

  # # scenario "Print Home menu item" do
  #   menu_rails.each do |menu_rails_item|
  #     scenario "Print #{ menu_rails_item[:text] } menu item" do
  #       visit root_path

  #       page.should have_content(menu_rails_item[:text])
  #     end
  #   end

end