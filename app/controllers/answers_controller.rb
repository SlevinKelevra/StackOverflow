class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question
    else
      flash[:notice] = 'Your answer was not saved.'
      render 'questions/new'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
