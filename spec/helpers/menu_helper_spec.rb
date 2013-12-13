require 'spec_helper'

describe MenuRails::Helpers::MenuHelper do
  let(:menu)        { MenuRails::Menu.get_menu_by_mrid(:client)               }
  let(:menu_helper) { Class.new{ include MenuRails::Helpers::MenuHelper }.new }

  it { menu_helper.menu_rails(menu).first.text.should == 'Home' }

end