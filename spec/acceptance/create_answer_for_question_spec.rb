require 'rails_helper'

feature 'Create answer for question', %q{
In order to create the answer for the question
As a user
I have the opportunity
} do
  given(:user) { create :user }
  given(:question) { create :question }

  scenario 'Authenticated user creates answer' do
    sign_in(user)
    visit question_path(question)

    fill_in 'Input your answer', with: 'answer_body'
    click_on 'Post your answer'

    expect(page).to have_content 'answer_body'
    expect(page).to have_content 'Your answer was successfully created.'
  end

  scenario 'Non-authenticated user creates answer' do
    visit question_path(question)
    click_on 'Post your answer'

    expect(page).to have_content 'need to sign in'
  end

  scenario 'Authenticated user creates non-valid answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Post your answer'
    expect(page).to have_content "Body can't be blank"
  end

end