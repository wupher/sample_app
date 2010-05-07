require 'spec_helper'

describe PagesController do
  
  integrate_views

  before(:each) do
    print "begin new test:\n"
  end

  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end


  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_tag("title",'home')
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_tag("title",'Contact')
    end
  end

  describe "Get 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end
end
