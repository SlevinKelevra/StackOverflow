require 'rails_helper'

feature 'Delete files to question', %q{
  In order to delete files to question
  As an question author
  I want to be able to delete my files to questions
} do

  given(:user) { create :user }
  given(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }
  given(:question) { create :question, user: user }
  given(:user_without_question) { create :user }

  scenario 'Author deletes file', js: true do
    sign_in(user)
    question.attachments.create(file: file)
    visit question_path(question)

    within '.question' do
      click_on 'Delete file'
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end

  scenario 'Non - Author deletes file', js: true do
    sign_in(user_without_question)
    question.attachments.create(file: file)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Delete file'
    end
  end


end