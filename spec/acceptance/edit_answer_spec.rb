require 'rails_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given!(:user) { create :user }
  given!(:question) { create :question }
  given!(:answer) { create(:answer, user: user, question: question) }
  given!(:user_without_question) { create :user }

  scenario 'Unauthenticated user try to edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  scenario 'Edit answer as an author', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_link 'Edit'
      click_on 'Edit'

      fill_in 'Edit answer', with: 'edit_body'
      click_on 'Save'

      expect(page).to_not have_content answer.body
      expect(page).to have_content 'edit_body'
      expect(page).to_not have_selector 'textarea'
    end

  end

  scenario 'Edit answer as an non-author' do
    sign_in(user_without_question)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end

end