require 'spec_helper'

describe MenuRails::MenuItem do

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu_item)}.should_not raise_error
  end
  
  let(:menu_item) { FactoryGirl.build(:menu_item) }

  it do
    menu_item.should respond_to(:mriid,
                                :text,
                                :menu,
                                :authorization,
                                :url)
  end

  it { menu_item.text.should be_an_instance_of String                    }
  it { menu_item.mriid.should be_an_instance_of Symbol                   }

  context "with menu :client as parent" do
    let(:menu)             { MenuRails::Menu.get_menu_by_mrid(:client) }
    let(:first_menu_item)  { menu.all_menu_items.first                 }
    let(:second_menu_item) { menu.all_menu_items.second                }

    it { menu.get_menu_item_by_mriid(:home).should be first_menu_item                           }

    it { first_menu_item.menu.should be menu                                                    }
    it { first_menu_item.authorization.should == { can: :read, class_name: 'PagesController' }  }
    it { first_menu_item.url.should == '/'                                                      }

    it { second_menu_item.authorization.should be nil                                           }
    it { second_menu_item.url.should == second_menu_item.url_text                               }

  end

end