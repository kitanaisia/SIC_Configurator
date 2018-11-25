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
    post :to_start
    post :draw, on: :collection
    post :back, on: :collection
    post :enter, on: :collection
    post :enter_from_top, on: :collection
    post :to_top, on: :collection
    post :to_bottom, on: :collection
    post :setlist_open, on: :collection
    post :live, on: :collection
    member do
      get :battle
      get :display
    end
  end

  post "/members/:id", to: "decks#add"
end
