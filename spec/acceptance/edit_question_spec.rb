require 'rails_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of question
  I'd like ot be able to edit my question
} do

  given!(:author) { create :user }
  given!(:question) { create :question, user: author }
  given!(:user) { create :user }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  scenario 'Edit question as an author', js: true do
    sign_in(author)
    visit question_path(question)

    within '.question' do
      expect(page).to have_link 'Edit'
      click_on 'Edit'

      save_and_open_page
      fill_in 'Edit title question', with: 'edit_title'
      fill_in 'Edit body question', with: 'edit_body'
      click_on 'Save'

      expect(page).to_not have_content question.title
      expect(page).to_not have_content question.body
      fill_in 'Edit title question', with: 'edit_title'
      fill_in 'Edit body question', with: 'edit_body'
      expect(page).to have_content 'edit_title'
      expect(page).to have_content 'edit_body'
      expect(page).to_not have_selector 'textarea'
    end

  end

  scenario 'Edit answer as an non-author' do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Edit'
    end
  end

end