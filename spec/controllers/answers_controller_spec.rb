require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }

  describe 'POST #create' do
    sign_in_user
    let(:params) { { answer: attributes_for(:answer), question_id: question } }
    let(:invalid_params) { { answer: attributes_for(:invalid_answer), question_id: question } }

    context 'with valid attributes' do
      it 'saves new answer in database' do
        expect { post :create, params: params }.to change(question.answers, :count).by(1)
      end
      it 'associates new answer with user' do
        expect { post :create, params: params }.to change(@user.answers, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: params
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: invalid_params }.to_not change(Answer, :count)
      end
      it 're-renders new view' do
        post :create, params: invalid_params
        expect(response).to render_template 'questions/new'
      end
    end
  end
end