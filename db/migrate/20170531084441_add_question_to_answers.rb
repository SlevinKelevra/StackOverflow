class AddQuestionToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :answers, :question
  end
end