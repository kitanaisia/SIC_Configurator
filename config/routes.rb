Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'members#index'
  resources :cards
  resources :members do
    post :buy
  end
  resources :musics do
    post :buy
  end
  resources :decks do
    post :remove_member
    post :remove_music
    post :draw, on: :collection
    member do
      get :battle
    end
  end

  post "/members/:id", to: "decks#add"
end
