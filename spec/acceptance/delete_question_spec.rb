require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  As an question author
  I want to be able to delete my questions
} do

  given(:user) { create :user }
  given(:question) { create(:question, user: user) }
  given(:user_without_question) { create :user }


end