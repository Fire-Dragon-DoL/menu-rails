require 'spec_helper'

describe MenuRails::MenuItem do

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu_item)}.should_not raise_error
  end
  
  let(:menu_item) { FactoryGirl.build(:menu_item) }

  it { menu_item.should respond_to(:mriid, :text, :menu, :authorization) }
  it { menu_item.text.should be_an_instance_of String                    }
  it { menu_item.mriid.should be_an_instance_of Symbol                   }

  context "with menu :client as parent" do
    let(:menu)      { MenuRails::Menu.get_menu_by_mrid(:client) }
    let(:menu_item) { menu.all_menu_items.first                 }

    it { menu_item.menu.should be menu                                                    }
    it { menu.get_menu_item_by_mriid(:home).should be menu_item                           }
    it { menu.all_menu_items.second.authorization.should be nil                           }
    it { menu_item.authorization.should == { can: :read, class_name: 'PagesController' }  }

  end

end