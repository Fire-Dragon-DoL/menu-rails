require 'menu-rails'

FactoryGirl.define do

  factory :menu, class: MenuRails::Menu do
    sequence(:mrid) { |n| "menu_#{ n }" }
  end

  factory :menu_item, class: MenuRails::MenuItem do
    sequence(:mriid) { |n| "menu_item_#{ n }" }
    text             { Faker::Lorem.word }
    # name { Faker::Name.first_name }

    # factory :dummy_invalid do
    #   will_invalidate true
    # end
  end

end
