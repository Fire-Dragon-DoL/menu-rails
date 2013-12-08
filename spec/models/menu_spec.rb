require 'spec_helper'

describe MenuRails::Menu do
  let(:menu) { FactoryGirl.build(:menu) }

  it "has a valid factory" do
    -> {FactoryGirl.build(:menu)}.should_not raise_error
  end

  it { menu.should respond_to(:id) }

end