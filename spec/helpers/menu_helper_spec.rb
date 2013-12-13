require 'spec_helper'

describe MenuRails::Helpers::MenuHelper do
  let(:menu) { MenuRails::Menu.get_menu_by_mrid(:client) }

  it { view.menu_rails(menu).first.text.should == 'Home'               }
  it { view.menu_rails(menu).map(&:text).should include('Not visible') }

  context "with cancan" do
    before(:each) do
      view.stub(:can?) do |accessor, klass|
        klass != NotVisibleController
      end
    end

    it { view.menu_rails(menu).map(&:text).should_not include('Not visible') }

  end

end