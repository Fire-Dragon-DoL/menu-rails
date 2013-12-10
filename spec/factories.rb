require 'menu-rails'

FactoryGirl.define do

  factory :menu, class: MenuRails::Menu do
    sequence(:mid) { |n| "menu_#{ n }" }
  end

  factory :menu_item, class: MenuRails::MenuItem do
    sequence(:miid) { |n| "menu_item_#{ n }" }
    text            { Faker::Lorem.word }
    # name { Faker::Name.first_name }

    # factory :dummy_invalid do
    #   will_invalidate true
    # end
  end

end
