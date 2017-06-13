class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def update
    @answer = Answer.find(params[:id])
    if current_user.author?(@answer)
      @question = @answer.question
      @answer.update(answer_params)
    else
      flash[:notice] = 'You cannot edit this answer.'
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user.author?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:notice] = 'You cannot delete this answer.'
    end
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
