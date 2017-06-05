Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'members#index'
  resources :cards
  resources :members do
    post :buy
  end
  resources :musics
  resources :decks

  post "/members/:id", to: "decks#add"
  post "/members/buy"
end
