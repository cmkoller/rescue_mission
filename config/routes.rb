Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "questions#index"
  resources :questions do
    resources :answers, only: [:create, :show]
  end
end
