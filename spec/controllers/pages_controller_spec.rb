require 'spec_helper'
require 'internal/app/controllers/pages_controller'

describe PagesController do

  it "assigns @menu" do
    get :home

    assigns(:menu).should be_an_instance_of(MenuRails::Menu)
  end

end