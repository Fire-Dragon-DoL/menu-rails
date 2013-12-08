require 'spec_helper'

feature "Menu generation" do

  scenario "Ensure capybara is working correctly" do
    visit '/'

    expect(page).to have_content("Capybara working correctly")
  end

end