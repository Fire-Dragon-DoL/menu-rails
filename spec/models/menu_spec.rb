require 'spec_helper'

describe MenuRails::Menu do

  it { described_class.should respond_to(:get_menu_by_mid)                                              }
  it { described_class.get_menu_by_mid(:client).should be_an_instance_of described_class                }
  it { described_class.get_menu_by_mid(:not_exist).should be_nil                                        }

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu)}.should_not raise_error
  end

  let(:menu) { FactoryGirl.build(:menu) }

  it { menu.should respond_to(:menu_items, :mid)                                                        }
  it { menu.menu_items.should respond_to(:size, :each)                                                  }
  it { menu.mid.should be_a_kind_of Symbol                                                              }

end