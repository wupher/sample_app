require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should render_template('pages/home')
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should render_template('pages/contact')
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should render_template('pages/about')
  end

  it "should have a help page at '/help'" do
    get '/help'
    response.should render_template('pages/help')
  end

  it "should have a Sign page at '/signup'" do
    get '/signup'
    response.should render_template('users/new')
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    response.should render_template('pages/about')
    click_link "Help"
    response.should render_template('pages/help')
    click_link "Home"
    response.should render_template('pages/home')
    click_link "Sign Up Now!"
    response.should render_template('users/new')
  end
end
