Bloccit::Application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show, :index]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts'  
     
  end
  resources :posts, only: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  

  	get 'about'=> 'welcome#about'
  
  	root to: 'welcome#index'
end
