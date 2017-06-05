require 'rails_helper'

feature 'User may view the questions', %q{
In order to view the questions
As a user
I should be able to see them.
} do

    given(:user) { create :user }
    given(:questions) { create_list(:question, 2) }

    scenario 'Authenticated user view questions' do
      sign_in(user)
      list_questions(questions)
    end

    scenario 'Non-Authenticated user view questions' do
      list_questions(questions)
    end
end
