Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :groups, except: [:index, :show, :destroy] do
    resources :messages, only: [:index, :create]
  end
  resource :user, only: :search do
    get :search, on: :collection
  end
end
