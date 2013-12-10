require 'spec_helper'

describe MenuRails::MenuItem do

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu_item)}.should_not raise_error
  end
  
  let(:menu_item) { FactoryGirl.build(:menu_item) }

  it { menu_item.should respond_to(:mriid, :text, :menu) }
  it { menu_item.text.should be_an_instance_of String    }
  it { menu_item.mriid.should be_an_instance_of Symbol   }

  context "with menu :client as parent" do
    let(:menu)      { MenuRails::Menu.get_menu_by_mrid(:client) }
    let(:menu_item) { menu.menu_items.first                     }

    it { menu_item.menu.should be menu }

  end

end