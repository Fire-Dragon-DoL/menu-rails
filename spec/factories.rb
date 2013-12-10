require 'menu-rails'

FactoryGirl.define do

  factory :menu, class: MenuRails::Menu do
    sequence(:mid) { |n| "menu_item_#{ n }" }
  end

  factory :menu_item, class: MenuRails::MenuItem do
    # name { Faker::Name.first_name }

    # factory :dummy_invalid do
    #   will_invalidate true
    # end
  end

end
