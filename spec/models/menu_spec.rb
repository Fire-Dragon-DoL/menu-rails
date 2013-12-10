require 'spec_helper'
require 'active_record'

describe MenuRails::Menu do
  let(:menu) { FactoryGirl.build(:menu) }

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu)}.should_not raise_error
  end

  it do
    menu.should respond_to( :find_by_mid,
                            :menu_items )
  end

  it { menu.menu_items.should respond_to(:size, :each)                                   }
  it { described_class.should respond_to(:all_in_file)                                   }
  it { described_class.all_in_file.should_not be_nil                                     }
  it { described_class.all_in_file.should include( :client,
                                                   :admin )                              }

  it { menu.find_by_mid(:client).should be_an_instance_of(described_class)               }
  it { -> {menu.find_by_mid(:not_exist)}.should raise_error ActiveRecord::RecordNotFound }

end