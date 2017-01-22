Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'members#index'
  resources :cards
  resources :members
  resources :musics
  resources :decks
end
