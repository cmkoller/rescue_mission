Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :show]
  end
end
