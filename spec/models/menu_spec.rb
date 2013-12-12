require 'spec_helper'

describe MenuRails::Menu do

  it { described_class.should respond_to(:get_menu_by_mrid)                               }
  it { described_class.get_menu_by_mrid(:client).should be_an_instance_of described_class }
  it { described_class.get_menu_by_mrid(:not_exist).should be_nil                         }
  it { described_class.get_menu_by_mrid(:client).mrid.should be :client                   }

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu)}.should_not raise_error
  end

  it "has a mrid that is always a symbol" do
    menu      = FactoryGirl.build(:menu)
    menu.mrid = 'test'
    menu.mrid.should be_an_instance_of Symbol
  end

  let(:menu) { described_class.get_menu_by_mrid(:client) }
  
  it { menu.should respond_to(:menu_items, :mrid)      }
  it { menu.menu_items.should respond_to(:size, :each) }
  it { menu.mrid.should be_a_kind_of Symbol            }
  it { menu.menu_items.first.text.should match 'Home'  }
  it { menu.all_menu_items.should be menu.menu_items   }

end