require 'spec_helper'
require 'rails_helper'

feature 'create new goals' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
  end

  scenario 'has a create goal page' do
    expect(page).to have_content "Add a goal"
  end


  scenario 'redirects to goal show page after adding a goal' do
    fill_in_goal("App Academy", "Find a job", "Public")
    expect(page).to have_content "Find a job"
  end

  scenario 'adds new goal' do
    fill_in_goal("App Academy", "Find a job", "Public")
    expect(page).to have_content "App Academy"
  end
end

feature 'private goals' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("Classified!", "Secret goal", "Private")
  end

  scenario 'users can see their own private goals' do
    expect(page).to have_content "Classified!"
  end

  scenario 'users can\'t see other people\'s private goals' do
    click_button('Log out')
    visit eva_url
    expect(page).not_to have_content "Classified!"
  end

end

feature 'public goals' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("For everybody!", "Non-Secret goal", "Public")
  end

  scenario 'users can see their own public goals' do
    expect(page).to have_content "For everybody!"
  end

  scenario 'users can see other people\'s public goals' do
    click_button('Log out')
    visit eva_url

    expect(page).to have_content "For everybody!"
  end

end

feature 'Update Goals' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("For everybody!", "Non-Secret goal", "Public")
  end

  scenario 'users can change goal content' do
    click_button("Edit Goal")
    fill_in_goal("Everybody!", "Edited goal", "Public")
    expect(page).to have_content "Edited goal"
  end
end

feature 'Delete Goals' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("For everybody!", "Non-Secret goal", "Public")
  end

  scenario 'goal page has option to remove goal' do
    expect(page).to have_button('Delete Goal')
  end

  scenario 'deleting a goal removes it from the user\'s page' do
    click_button 'Delete Goal'
    expect(page).not_to have_content('For everybody!')
  end

end

feature 'check progress' do
  before(:each) do
    log_in_as_eva
    visit new_goal_url
    fill_in_goal("For everybody!", "Non-Secret goal", "Public")
  end

  scenario 'users can declare goals as completed' do
    expect(page).to have_button('Goal completed!')
  end

  scenario 'users can declare goals as incomplete' do
    click_button 'Goal completed!'
    expect(page).to have_button('Still working on it.')
  end

  scenario 'completed goals appear on list on user page' do
    click_button 'Goal completed!'
    visit eva_url
    expect(page).to have_content('Completed Goals: 1 For everybody!')
  end

end
