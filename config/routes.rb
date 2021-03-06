Rails.application.routes.draw do

  devise_for :users
  resources :questions do
    resources :answers, shallow: true do
      patch :best, on: :member
      end
  end

  resources :attachments, only: :destroy

  root 'questions#index'

end
