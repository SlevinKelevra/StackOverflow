require 'rails_helper'

feature 'User create question', %q{
In order to ask a question
As a user
I want to be able to create i
} do
  scenario 'User try to create a question' do
    visit new_question_path
    fill_in 'Title', with: 'My title'
    fill_in 'Body', with: 'My text'
    click_on 'Create'

    expect(page).to have_content 'My title'
    expect(page).to have_content 'My text'
  end

  scenario 'User creates non-valid question' do
    visit new_question_path
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Title can't be blank"
  end
end