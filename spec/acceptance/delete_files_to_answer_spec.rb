require 'rails_helper'

feature 'Remove files from question', %q{
  In order to edit my answer files
  As an answer author
  I want to be able to delete files
} do
  given(:user) { create :user }
  given(:question) { create :question }
  given(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }
  given(:answer) { create :answer, user: user, question: question }
  given(:user_without_question) { create :user }

  scenario 'Author deletes file', js: true do
    sign_in(user)
    answer.attachments.create(file: file)
    visit question_path(question)

    within '.answers' do
      click_on 'Delete file'
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end

  scenario 'Non authro is not able to delete files', js: true do
    sign_in(user_without_question)
    answer.attachments.create(file: file)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Delete file'
    end
  end

end