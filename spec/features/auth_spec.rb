require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before(:each) do
    visit new_user_url
  end

  scenario "has a new user page" do
    expect(page).to have_content "New User"
  end


  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      sign_up_as_eva
      expect(page).to have_content "eva"
    end

    scenario "doesn't accept blank passwords" do
      sign_up("test")
      expect(page).to have_content "Password is too short"
    end

    scenario "doesn't accept blank usernames" do
      sign_up("", "aaaaaa")
      expect(page).to have_content "Username can't be blank"
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    log_in_as_eva
    expect(page).to have_content "eva"
  end

end

feature "logging out" do

  scenario "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content "Sign in"
  end

  scenario "doesn't show username on the homepage after logout" do
    log_in_as_eva
    save_and_open_page
    click_button('Log out')
    expect(page).not_to have_content "eva"
  end

end
