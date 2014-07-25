Bloccit::Application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show]

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
      
    end
  end
  	get 'about'=> 'welcome#about'
  
  	root to: 'welcome#index'
end
