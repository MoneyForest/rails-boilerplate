# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#home'
  get 'top', to: 'home#top'
  get 'mypage', to: 'home#mypage'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks:  'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users

  get '/api/v1/users/:id', to: 'api/v1/users#show'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
