require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }
    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end
    it 'assignes new answer to question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'associates new question with user' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(@user.questions, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:question_user) { create(:question, user: @user) }
    let!(:question) { create :question }

    context 'author deletes question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: question_user } }.to change(Question, :count).by(-1)
      end
      it 'redirects to index view' do
        delete :destroy, params: { id: question_user }
        expect(response).to redirect_to questions_path
      end
    end

    context 'non-author tries to delete question' do
      it 'deletes question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end
      it 'redirects to index view' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
