require 'spec_helper'

describe MenuRails::Helpers::MenuHelper do
  let(:menu) { MenuRails::Menu.get_menu_by_mrid(:client) }

  it { view.menu_rails(menu).first.text.should == 'Home'                           }
  it { view.menu_rails(menu).map(&:text).should include('Not visible')             }
  it { view.menu_rails(menu){ |menu_item| break menu_item.active? }.should be_true }

  it "is not active because url it's a string" do
    view.menu_rails(menu) do |menu_item, index|
      break menu_item.active? if index == 1
    end.should be_false
  end

  context "with cancan" do
    before(:each) do
      view.stub(:can?) do |accessor, klass|
        klass != NotVisibleController
      end
    end

    it { view.menu_rails(menu).map(&:text).should_not include('Not visible') }

  end

end