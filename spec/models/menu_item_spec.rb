require 'spec_helper'

describe MenuRails::MenuItem do
  let(:menu_item) { FactoryGirl.build(:menu_item) }

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu_item)}.should_not raise_error
  end

  it { menu_item.should respond_to(:text) }

end