class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index, :update]
  before_action :set_question, only: [:show, :edit, :destroy, :update]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def edit; end

  def new
    @question = Question.new
    @question.attachments.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    if current_user.author?(@question)
      @question.destroy
      flash[:notice] = 'Your question successfully deleted.'
    else
      flash[:notice] = 'You cannot delete this question.'
    end
    redirect_to questions_path
  end

  def update
    @question.update(question_params) if current_user.author?(@question)
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body, :title, attachments_attributes: [:file])
  end
end
