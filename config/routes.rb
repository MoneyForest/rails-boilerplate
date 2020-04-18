Rails.application.routes.draw do
  root 'home#home'
  get 'top', to: "home#top"
  get 'mypage', to: "home#mypage"

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#destroy"
  end

  resources :users

end
