Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]

  resources :users

  resources :subs, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  resources :posts, only: [:create, :edit, :show, :update, :new, :index] 

  resources :comments, only: [:create, :show]
end
