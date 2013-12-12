require 'spec_helper'

describe MenuRails::Helpers::MenuHelper do
  let(:menu)        { MenuRails::Menu.get_menu_by_mrid(:client)               }
  let(:menu_helper) { Class.new{ include MenuRails::Helpers::MenuHelper }.new }

  it { menu_helper.menu_rails_each(menu).should be_an_instance_of Enumerator                                }
  it { menu_helper.menu_rails_item(menu.all_menu_items.first) { |menu_text| menu_text }.should match 'Home' }

end