require 'menu-rails'

FactoryGirl.define do

  factory :menu, class: MenuRails::Menu do
  end

  factory :menu_item, class: MenuRails::MenuItem do
    # name { Faker::Name.first_name }

    # factory :dummy_invalid do
    #   will_invalidate true
    # end
  end

end
