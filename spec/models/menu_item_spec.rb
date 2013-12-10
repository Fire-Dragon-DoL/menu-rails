require 'spec_helper'

describe MenuRails::MenuItem do

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu_item)}.should_not raise_error
  end
  
  let(:menu_item) { FactoryGirl.build(:menu_item) }

  it { menu_item.should respond_to(:miid, :text, :menu) }
  it { menu_item.text.should be_an_instance_of String   }
  it { menu_item.miid.should be_an_instance_of Symbol   }

end