require 'spec_helper'
require 'rails_helper'

feature 'create goal comments' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("Declassified!", "Not secret goal", "Public")
    click_button "Log out"

    log_in_as_louie
    visit eva_url
    click_link("Declassified!")
  end

  scenario 'goal show page has a comment form' do
    expect(page).to have_content("Comment on this goal:")
  end

  scenario 'users can add a comment to a goal page' do
    fill_in "Comment on this goal:", with: "This is an amazing goal."
    click_button "Submit"
    expect(page).to have_content("This is an amazing goal.")
  end
end

feature 'user comments' do
  before(:each) do
    log_in_as_eva
    click_button "Log out"
    log_in_as_louie
    visit eva_url
  end

  scenario 'user profile has a comment form' do
    expect(page).to have_content("Leave a note:")
  end

  scenario 'notes show up on user profile' do
    fill_in "Leave a note:", with: "Way to go Eva."
    click_button "Submit"
    expect(page).to have_content("Way to go Eva.")
  end

end

feature 'comments do not cross-post' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("Declassified!", "Not secret goal", "Public")
    click_button "Log out"

    log_in_as_louie
    visit eva_url
    fill_in "Leave a note:", with: "Way to go Eva."
    click_button "Submit"
    click_link "Declassified!"
  end

  scenario 'note for user does not show on goal page' do
    expect(page).not_to have_content("Way to go Eva.")
  end

  scenario 'note for goal does not show on user page' do
    fill_in "Comment on this goal:", with: "This is an amazing goal."
    click_button "Submit"
    visit eva_url
    expect(page).not_to have_content("This is an amazing goal.")
  end
end
