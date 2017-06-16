require 'rails_helper'

feature 'Best answer', %q{
  To show whose answer helped me
  As an author of answer
  I want to be able to choose the best answer
} do

  given!(:author) { create :user }
  given!(:user) { create :user }
  given!(:question) { create :question, user: author, answers: create_list(:answer, 2) }

  scenario 'Unauthenticated user try select to best answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Best answer'
  end

  scenario 'Author select best answer', js: true do
    sign_in(author)
    visit question_path(question)

    expect(page).to have_link 'Best answer'

    save_and_open_page
    last_answer = question.answers.last

    within("#answer-#{last_answer.id}") do
      click_link('Best answer')
    end

    expect(page).to have_content 'Best answer'
    expect(first('.answers')).to have_content(last_answer.body)
  end

  scenario 'Best answer as an select non-author' do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link 'Best answer'
    end
  end

end