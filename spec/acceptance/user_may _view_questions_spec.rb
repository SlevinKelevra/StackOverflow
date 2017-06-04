require 'rails_helper'

feature 'User may view the questions', %q{
In order to view the questions
As a user
I should be able to see them.
} do

  given(:questions) { create_list(:question, 2) }

  scenario 'User may view the questions' do
    list_questions(questions)
  end

end