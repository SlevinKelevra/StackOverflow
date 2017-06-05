require 'rails_helper'

feature 'Create answer for question', %q{
In order to create the answer for the question
As a user
I have the opportunity
} do
  given(:question) { create :question }

end