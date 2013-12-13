require 'spec_helper'

describe MenuRails::Helpers::MenuHelper do
  let(:menu) { MenuRails::Menu.get_menu_by_mrid(:client) }

  it { view.menu_rails_all_items(menu).first.text.should == 'Home'               }
  it { view.menu_rails_all_items(menu).map(&:text).should include('Not visible') }

  it "is not active because url it's a string" do
    view.menu_rails(menu){ |menu_items| menu_items.second.active? }.should be_false
  end

  context "with cancan" do
    before(:each) do
      view.stub(:can?) do |accessor, klass|
        klass != NotVisibleController
      end
    end

    it { view.menu_rails_all_items(menu).map(&:text).should_not include('Not visible') }

  end

end