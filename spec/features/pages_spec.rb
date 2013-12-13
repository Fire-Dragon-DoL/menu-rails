require 'spec_helper'
require 'active_support/all'

feature "Menu generation" do
  let(:menu) { MenuRails::Menu.get_menu_by_mrid(:client) }

  before(:each) do
    ActionView::Base.any_instance.stub(:can?) do |accessor, klass|
      klass != NotVisibleController
    end
  end

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

    scenario "Home is active" do
      visit root_path

      find('#menu a.is-active').should have_content('Home')
    end

    context "with custom MenuItem" do

      scenario "Dumm1 active? not called, instead it's called always_inactive" do
        menu.get_menu_item_by_mriid(:dummy1).should_receive(:always_inactive).with(no_args).and_call_original

        visit root_path
      end

    end

  end

end